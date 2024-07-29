#!/bin/env perl
package netlist;
require Exporter;
use File::Basename;
use Parse::Lex;
use Scalar::Util qw(looks_like_number);
use Data::Dump qw(dump);
use Data::Dumper;
use constant {
    CIR_WIDTH => 80,
    IN => 1,
    OUT => 2,
    INOUT => 3,
    MSB => 0,
    LSB => 1,
    DLT => 2,
    CNT => 3,
    DIV => 4, # DIM
    DEBUG => 1,
    QUIET => 2,
    KEEP_SEQ => 4,
    KEEP_STAR => 8,
    SAVE_VAL => 16,
    SAVE_NET_CHECK => 32,
};
our @ISA = qw(Exporter);
our %ENG = (""=> 1, qw(
    a 1e-18
    f 1e-15
    p 1e-12
    n 1e-9
    u 1e-6
    m 1e-3
    k 1e3
    x 1e6
    g 1e9

    A 1e-18
    F 1e-15
    P 1e-12
    N 1e-9
    U 1e-6
    M 1e-3
    K 1e3
    X 1e6
    G 1e9
));

sub float_to_eng {
    my ($val, $fmt) = @_;
    $fmt //= "%.3f";
    $val =~ s/^([+-])//;
    my $symbol = $1;
    my $eng = $val > 1 ? (
        $val >= $ENG{g} ? 'g' :
        $val >= $ENG{x} ? 'x' :
        $val >= $ENG{k} ? 'k' : ""
    ) : (
        $val < $ENG{f} ? 'a' :
        $val < $ENG{p} ? 'f' :
        $val < $ENG{n} ? 'p' :
        $val < $ENG{u} ? 'n' :
        $val < $ENG{m} ? 'u' :
        $val < 1       ? 'm' : ""
    );

    $val = sprintf($fmt, $val/$ENG{$eng});
    $val =~ s/\.?0+$//;
    return ($symbol . $val . $eng);
}

sub eng_to_float {
    my ($eng) = @_;
    return $eng =~ $qrENG ? $1 * $ENG{$2} : $eng;
}
our (@spi, @spi_files, %spi_files) = ();
our (%subckts, %globals, %shorts, @connect) = ();
our $casefun = \&_lc_;
our ($e_notation, $mode, $error, $errlog) = (0, 0, 0);
our $qrREAL = qr/^\-?\d+(?:\.\d=)?$/;
our $qrENG = qr/^([+-]?\d+(?:\.\d+)?)[@{[keys %ENG]}]$/; # eng-notation
our $qrNUM = qr/^\-?\d+(?:\.\d+)?(?:[@{[keys %ENG]}])?$/; # real or eng
our $qrBUS = qr/\[(\d+)(?:\:(\d+)(?:\:(\d+))?)?\]/;
our @MOS_PINDIR = (OUT, IN, OUT); # D, G, S
our ($M, @diode_pins) = ();
our @lex = qw(
    RIGHTP  [\)]
    LEFTP   [\(]
    OP      [-+/*]
    CMP     [<=>]=?
    LOGI    (?:\&\&)|(?:\|\|)
    ENG     \.?\d+(?:\.\d*)?[@{[keys %ENG]}][mM]?
    REAL    \.?\d+(?:\.\d*)?
    WORD    \w+
    CHAR    .
);
our $lexer = Parse::Lex->new(@lex);

sub _lc_ { return lc shift @_; }
sub _uc_ { return uc shift @_; }
sub _pc_ { return shift @_; }
sub set_case_up { $casefun = \$_uc_; }
sub set_case_preserve { $casefun = \$_pc_; }
sub set_debug { $mode |= DEBUG; }
sub set_quiet { $mode |= QUIET; }
sub set_save_val { $mode |= SAVE_VAL; }
sub set_keep_seq { $mode |= KEEP_SEQ; }
sub set_keep_star { $mode |= (KEEP_STAR | KEEP_SEQ); }
sub set_net_check { $mode |= SAVE_NET_CHECK; }
sub new {
    my $class = shift;
    my %par = @_;
    $class = ref($class) || $class;
    my $self = {
        error => "",
        DATA => {},
    };
    bless $self => $class;
    if (-e $par{file}) {
        $self->loadNetlist(%par);
    }
    return $self;
}

sub loadNetlist {
    my $self = shift;
    my %par = @_;
    if (!-e $par{file}) {
        $self->{error} = "netlist file $par{file} does not exist!!!";
        return 0;
    }
    $self->{NETLIST_FILE} = $par{file};
    $self->{NETLIST_PATH} = dirname($par{file});
    #read netlist
    my @include_files;
    my @dataArray;
    open(FILE, $par{file}) || BEGIN {$self->{error} = "open netlist file failed!!!"; return 0};
    while(<FILE>) {
        my $row = $_;
        chomp($row);
        next if $row =~ /^\s*$/;
        #include
        if ($row =~ m/^[.][inc|include]\w*\s*[\"\'](.+)[\"\']\s*$/i) {
            push @include_files, $1;
        }
        if ($row =~ m/^\+(\s*.*)/) {
            $dataArray[-1] .= $1;
        } else {
            push @dataArray, $row;
        }
    }
    close FILE;
    if (@include_files) {
        $self->loadNetlist(file=>"$self->{NETLIST_PATH}/$_") foreach @include_files;
    }
    #parsing
    my @suffixList = (".cir");
    my $netlist = {
        NAME => basename($par{file}, @suffixList),
        INCLUDE => [],
    };
    my $param = {};
    my $blockFlag = "";
    my $subcktInfo = {};
    my $deviceSeq = 1;
    my $subcktSeq = 1;
    foreach my $row (@dataArray) {
        if ($row =~ /^\*\*/) {
            next;
        }
        #blockFlag
        if ($row =~ /^\.PARAM$/) {
            $blockFlag = "PARAM";
        }
        if ($row =~ /^\.SUBCKT\s*/) {
            $blockFlag = "SUBCKT";
        }
        #PARAM
        if ($blockFlag =~ /PARAM/i) {
            if ($row =~ /^\*\.GLOBAL\s(\S+):(\S+)$/i) {
                $param->{GLOBAL}{$1} = $2;
            } elsif ($row =~ /^\*\.CONNECT\s(\S+)\s(\S+)$/i) {
                push @{$param->{CONNECT}{$1}}, $2;
            } elsif ($row =~ /^\*\.(\S+)\s*(.*)$/i && $row !~ /GLOBAL/) {
                $param->{$1} = $2;
            }
        }
        #INCLUDE
        if ($row =~ /^\.[inc|include]\w*\s*[\"\'](.+)\[\"\']\s*$/i) {
            push @{$netlist->{INCLUDE}}, $1;
        }
        #SUBCKT
        if ($row =~ /^\.SUBCKT/i) {
            my @tmp = split(/\s+/, $row);
            $subcktInfo->{NAME} = $tmp[1];
            foreach my $index (2..$#tmp) {
                if ($tmp[$index] =~ /^(\S+)\=(\S+)$/) {
                    $subcktInfo->{PROPERTY}{$1} = $2;
                } else {
                    push @{$subcktInfo->{PORT}}, $tmp[$index];
                }
            }
            $subcktInfo->{SEQUENCE} = $subcktSeq++;
        } elsif ($row =~ /^\.ENDS\s*/i) {
            $netlist->{SUBCKT}{$subcktInfo->{NAME}} = $subcktInfo;
            $subcktInfo = {};
        } elsif (exists $subcktInfo->{NAME} && $subcktInfo->{NAME} ne "") {
            if ($row =~ /^\*.*/) {
                next;
            }
            my $device = $self->parseDevice(line=>$row);
            unless ($device) {
                die "parse device fail! line : $row";
            }
            $device->{SEQUENCE} = $deviceSeq++;
            $subcktInfo->{DEVICE}{$device->{NAME}} = $device;
        }
    }
    $netlist->{PARAM} = $param;
    $self->{DATA}{$netlist->{NAME}} = $netlist;
    $self->buildNode(stop_cells=>$par{stop_cells});
    return 1;
}

sub parseDevice {
    my $self = shift;
    my %par = @_;
    my $line = $par{line};
    my @tmp = split(/\s+/, $line);
    if (scalar(@tmp) < 2) {
        dump "<2";
        return;
    }
    my $device = {};
    $device->{PROPERTY_LIST} = [];
    $device->{NAME} = $tmp[0];
    if ($device->{NAME} =~ /^[RC].*/i) {
        if (scalar(@tmp) < 3) {
            dump "<3";
            return;
        }
        push @{$device->{PORT}}, @tmp[1,2];
        push @{$device->{PROPERTY_LIST}}, @tmp[3..$#tmp];
        $device->{SYMBOL} = substr($tmp[0], 0, 1);
    } else {
        my $symbol_pos = 0;
        for (my $index = scalar(@tmp)-1; $index >0; $index--) {
            if ($tmp[$index] =~ /^(\S+)\=(\S+)$/ or looks_like_number($tmp[$index]) or $tmp[$index] =~ /^\$.*/) {
                next;
            } else {
                $symbol_pos = $index;
                last;
            }
        }
        if ($symbol_pos == 0) {
            dump "=0";
            return;
        }
        foreach my $index (1..$#tmp) {
            if ($index < $symbol_pos) {
                push @{$device->{PORT}}, $tmp[$index];
            } elsif ($index == $symbol_pos) {
                $device->{SYMBOL} = $tmp[$index];
            } else {
                push @{$device->{PROPERTY_LIST}}, $tmp[$index];
            }
        }
    }
    if (exists $device->{PROPERTY_LIST}) {
        foreach my $property_item (@{$device->{PROPERTY_LIST}}) {
            if ($property_item =~ /^(\S+)\=(\S+)$/) {
                $device->{PROPERTY}{$1} = $2;
            }
        }
    }
    return $device;
}

sub buildNode {
    my $self = shift;
    my %par = @_;
    my @stopCells;
    if (defined $par{stop_cells}) {
        @stopCells = @{$par{stop_cells}};
    }
    foreach my $netlist (values %{$self->{DATA}}) {
        foreach my $subckt (values %{$netlist->{SUBCKT}}) {
            next if grep {/^\Q$subckt->{NAME}\E$/i} @stopCells;
            my $node = {};
            foreach my $device (values %{$subckt->{DEVICE}}) {
                foreach my $PORT (@{$device->{PORT}}) {
                    push @{$node->{$PORT}}, $device->{NAME};
                }
            }
            $subckt->{NODE} = $node;
        }
    }
}

sub getData {
    my $self = shift;
    return $self->{DATA};
}

sub setData {
    my $self = shift;
    $self->{DATA} = shift;
}

sub isSubckt {
    my $self = shift;
    my %par = @_;
    foreach my $netlist (values %{$self->{DATA}}) {
        if (exists $netlist->{SUBCKT}{$par{name}}) {
            return 1;
        }
    }
    return 0;
}

sub getSubckt {
    my $self = shift;
    my %par = @_;
    foreach my $netlist (values %{$self->{DATA}}) {
        if (exists $netlist->{SUBCKT}{$par{name}}) {
            return $netlist->{SUBCKT}{$par{name}};
        }
    }
    return;
}

sub isMos {
    my $self = shift;
    my %par = @_;
    my $mos = $par{mos};
    if ($mos->{NAME} =~ /^M/ && $mos->{SYMBOL} =~ /P|N/i) {
        return 1;
    }
    return 0;
}

sub areDiffMos {
    my $self = shift;
    my %par = @_;
    my $mos1 = $par{mos1};
    my $mos2 = $par{mos2};
    if ($mos1->{SYMBOL} ne $mos2->{SYMBOL}) {
        return 1;
    }
    return 0;
}

sub getMosPort {
    my $self = shift;
    my %par = @_;
    my $mos = $par{mos};
    return unless $self->isMos($par);
    return {
        D=>$mos->{PORT}[0],
        G=>$mos->{PORT}[1],
        S=>$mos->{PORT}[2],
        B=>$mos->{PORT}[3],
    }
}

sub isSubcktPassgate {
    my $self = shift;
    my $par = @_;
    my $subckt = $self->getSubckt(%par);
    return 0 unless $subckt;
    my @devices = values %{$subckt->{DEVICE}};
    my $deviceCount = scalar(@devices);
    if ($deviceCount != 2) {
        return 0;
    }
    return $self->isPassgateFunction(device1=>$devices[0], device2=>$devices[1]);
}

sub isPassgateFunction {
    my $self = shift;
    my %par = @_;
    my $device1 = $par{device1};
    my $device2 = $par{device2};
    my @device1ports = @{$device1->{PORT}};
    my @device2ports = @{$device2->{PORT}};
    unless (($#device1ports == $#device2ports && $#device2ports == 3) &&
        ($device1->{SYMBOL} ne $device2->{SYMBOL}) &&
        $self->isMos(mos=>$device1) && $self->isMos(mos=>$device2)
    ) {
        return 0;
    }
    my $ports1 = $self->getMosPort(mos=>$device1);
    my $ports2 = $self->getMosPort(mos=>$device2);
    return 0 if ($ports1->{D} eq $ports1->{S} || $ports2->{D} eq $ports2->{S});
    if (($ports1->{D} eq $ports2->{D} && $ports1->{S} eq $ports2->{S} && $ports1->{G} ne $ports2->{G}) ||
        ($ports1->{D} eq $ports2->{S} && $ports1->{S} eq $ports2->{D} && $ports1->{G} ne $ports2->{G})
    ) {
        if (defined(exists $par{port})) {
            push @{$par{port}}, $ports1->{D};
            push @{$par{port}}, $ports1->{S};
        }
        return 1;
    }
    return 0;
}

sub isSubcktInverter {
    my $self = shift;
    my $par = @_;
    my $subckt = $self->getSubckt(%par);
    return 0 unless $subckt;
    my $devices = values %{$subckt->{DEVICE}};
    my $deviceCount = scalar(@devices);
    if ($deviceCount != 2) {
        return 0;
    }
    my $ret = $self->isInverterFunction(device1=>$devices[0], device2=>$devices[1]);
    return ($ret && scalar(@{$subckt->{PORT}}) == 2);
}

sub isInverterFunction {
    my $self = shift;
    my %par = @_;
    my $device1 = $par{device1};
    my $device2 = $par{device2};
    my @device1ports = @{$device1->{PORT}};
    my @device2ports = @{$device2->{PORT}};
    unless (($#device1ports == $#device2ports && $#device2ports == 3) &&
        ($device1->{SYMBOL} ne $device2->{SYMBOL}) &&
        $self->isMos(mos=>$device1) && $self->isMos(mos=>$device2)
    ) {
        return 0;
    }
    my $ports1 = $self->getMosPort(mos=>$device1);
    my $ports2 = $self->getMosPort(mos=>$device2);
    if ($ports1->{D} eq $ports2->{D} && $ports1->{G} eq $ports2->{G} && $ports1->{S} ne $ports2->{S}) {
        if (defined(exists $par{port})) {
            push @{$par{port}}, $ports1->{D};
            push @{$par{port}}, $ports1->{S};
        }
        return 1;
    }
    if ($ports1->{S} eq $ports2->{S} && $ports1->{G} eq $ports2->{G} && $ports1->{D} ne $ports2->{D}) {
        if (defined(exists $par{port})) {
            push @{$par{port}}, $ports1->{S};
            push @{$par{port}}, $ports1->{G};
        }
        return 1;
    }
    return 0;
}

sub isSubcktLatch {
    my $self = shift;
    my $par = @_;
    my $subckt = $self->getSubckt(%par);
    return 0 unless $subckt;
    my @devices = values %{$subckt->{DEVICE}};
    my $deviceCount = scalar(@devices);
    my $ret = 0;
    if ($deviceCount == 2) {
        $ret = $self->isLatchFunction(device1=>$devices[0],device2=>$devices[1]);
    } elsif ($deviceCount == 4) {
        $ret = $self->hasLatch(devices=>\@devices);
    }
    $ret = $self->isLatchFunction(device1=>$devices[0], device2=>$devices[1]);
    return ($ret && scalar(@{$subckt->{PORT}}) == 2);
}

sub isLatchFunction {
    my $self = shift;
    my %par = @_;
    my $device1 = $par{device1};
    my $device2 = $par{device2};
    my @device1ports = @{$device1->{PORT}};
    my @device2ports = @{$device2->{PORT}};
    unless ($#device2ports == $#device2ports && $#device2ports == 1) {
        return 0;
    }
    return 0 unless ($self->isSubcktInverter(name=>$device1->{SYMBOL}) && $self->isSubcktInverter(name=>$device2->{SYMBOL}));

    my $d1p1 = $device1ports[0];
    my $d1p2 = $device1ports[1];
    my $d2p1 = $device2ports[0];
    my $d2p2 = $device2ports[1];

    if ($d1p1 eq $d2p2 && $d1p2 eq $d2p1) {
        return 1;
    }
    return 0;
}

sub hasLatch {
    my $self = shift;
    my %par = @_;
    my @devices = @{$par{devices}};
    my @inverters;
    my $index = 1;
    my $alreadyChecked = {};
    foreach my $dev (@devices) {
        if ($self->isSubcktLatch(name=>$dev->{SYMBOL})) {
            return {input=>$dev->{PORT}[0], output=>$dev->{PORT}[1]};
        }
    }
    foreach my $mos1 (@devices) {
        foreach my $mos2 (@devices) {
            next if ($mos1->{NAME} eq $mos2->{NAME});
            my @names = sort ($mos1->{NAME}, $mos2->{NAME});
            my $checkKey = join("_", @names);
            next if (exists $alreadyChecked->{$checkKey});
            $alreadyChecked->{$checkKey} = 1;
            my $port = [];
            if ($self->isInverterFunction(device1=>$mos1, device2=>$mos2, port=>$port)) {
                my $property = $mos1->{PROPERTY};
                my ($width) = $property->{W} =~ /(\d+\.?\d*)U/;
                my ($length) = $property->{L} =~ /(\d+\.?\d*)U/;
                my $isWeek = 0;
                if (defined $width && defined $length && $width <= $length) {
                    $isWeek = 1;
                }
                push @inverters, {
                    NAME => "MYIV".$index,
                    DEVICE => {
                        $mos1->{NAME} => $mos1,
                        $mos2->{NAME} => $mos2,
                    },
                    IS_WEEK=>$isWeek,
                    PORT => $port,
                };
                $index++;
            }
        }
    }
    foreach my $dev (@devices) {
        if ($self->isSubcktInverter(name=>$dev->{SYMBOL})) {
            my $property = $dev->{PROPERTY};
            my $width;
            my $length;
            if (exists $property->{NW} and exists $property->{NL}) {
                ($width) = $property->{NW} =~ /(\d+\.?\d*)U/;
                ($length) = $property->{NL} =~ /(\d+\.?\d*)U/;
            }
            my $isWeek = 0;
            if (defined $width && defined $length && $width <= $length) {
                $isWeek = 1;
            } else {
                my $inverter = $self->getSubckt(name=>$dev->{SYMBOL});
                $property = $inverter->{PROPERTY};
                if (exists $property->{NW} and exists $property->{NL}) {
                    ($width) = $property->{NW} =~ /(\d+\.?\d*)U/;
                    ($length) = $property->{NL} =~ /(\d+\.?\d*)U/;
                }
                if (defined $width && defined $length && $width > 0 && $length > 0) {
                    if ($width <= $length) {
                        $isWeek = 1;
                    }
                } else {
                    foreach my $device (sort {$a->{SEQUENCE} <=> $b->{SEQUENCE}} values %{$inverter->{DEVICE}}) {
                        $property = $inverter->{PROPERTY};
                        ($width) = $property->{W} =~ /(\d+\.?\d*)U/;
                        ($length) = $property->{L} =~ /(\d+\.?\d*)U/;
                        if ($width <= $length) { 
                            $isWeek = 1;
                            last;
                        }
                    }
                }
            }
            $dev->{IS_WEEK} = $isWeek;
            push @inverters, $dev;
        }
    }
    foreach my $inverter1 (@inverters) {
        foreach my $inverter2 (@inverters) {
            next if ($inverter1->{NAME} eq $inverter2->{NAME});
            my $d1p1 = $inverter1->{PORT}[0];
            my $d1p2 = $inverter1->{PORT}[1];
            my $d2p1 = $inverter2->{PORT}[0];
            my $d2p2 = $inverter2->{PORT}[1];
            if ($d1p1 eq $d2p2 && $d1p2 eq $d2p1) {
                my $ret = {};
                #0 is output, 1 is input, week inverter input pin as latch output
                if ($inverter1->{IS_WEEK}) {
                    $ret->{input} = $d1p1;
                    $ret->{output} = $d1p2;
                } else {
                    $ret->{input} = $d1p2;
                    $ret->{output} = $d1p1;
                }
                return $ret;
            }
        }
    }
    return;
}

sub getChildDevicePath {
    my $self = shift;
    my $ret = {};
    my %par = @_;
    my $subcktName = $par{subckt_name};
    my $checkSubcktName = $par{check_subckt_name};
    my $needReport = defined($par{need_report}) ? $par{need_report} : 0;
    my $copyNeedReport = $needReport;
    $copyNeedReport = 1 if (defined $checkSubcktName && $subcktName =~ /^\Q$checkSubcktName\E$/i);
    my $help; $help = sub {
        my %par = @_;
        my $subcktName = $par{subckt_name};
        my $checkSubcktName = $par{check_subckt_name};
        my $filter = $par{not_include_filter};
        my $deeplevel = $par{deep_level} ? $par{deep_level} : 1;
        my $path = defined $par{path} ? $par{path} : $par{subckt_name};
        my $needReport = defined($par{need_report}) ? $par{need_report} : 0;
        my $subckt = $self->getSubckt(name=>$subcktName);
        unless($subckt) {
            $self->{error} = "Cannot find $subcktName";
        }
        $self->{TMP} = {} if (!exists $self->{TMP});
        my $copyNeedReport = $needReport;
        $copyNeedReport = 1 if (defined $checkSubcktName && $subcktName =~ /^\Q$checkSubcktName\E$/i);
        foreach my $device (sort {$a->{SEQUENCE} <=> $b->{SEQUENCE}} values %{$subckt->{DEVICE}}) {
            next if ($device->{SYMBOL} =~ /^ARRAY_/);
            my $newPath = $path . "." . $device->{NAME};
            my $isDeviceSubckt = $self->isSubckt(name=>$device->{SYMBOL});
            my $tmpDeviceInfo = {
                NAME => $device->{NAME},
                SYMBOL=>$device->{SYMBOL},
                IS_SUBCKT=>$isDeviceSubckt,
                PORT=>$device->{PORT},
                PARENT=>$path,
                SEQUENCE=>++$self->{TMP_SEQ},
                DEEP_LEVEL=>$deeplevel,
                REPORT=>$copyNeedReport
            };
            if ($isDeviceSubckt) {
                if (defined $filter && $device->{SYMBOL} =~ /$filter/) {
                    next;
                }
            }
            $ret->{$newPath} = $tmpDeviceInfo;
            if ($isDeviceSubckt) {
                $help->(
                    @_,
                    check_subckt_name=>$checkSubcktName,
                    subckt_name=>$device->{SYMBOL},
                    path=>$newPath,
                    deep_level=>$deeplevel+1,
                    not_include_filter=>$filter,
                );
            }
        }
        return $ret;
    };
    $help->(@_);
    if ($self->isSubckt(name=>$subcktName)) {
        my $subckt = $self->getSubckt(name=>$subcktName);
        $ret->{$subcktName} = {
            NAME => $subcktName,
            SYMBOL => $subcktName,
            IS_SUBCKT=>1,
            SEQUENCE=>0,
            DEEP_LEVEL=>0,
            REPORT=>$copyNeedReport,
        };
    }
    return $ret;
}