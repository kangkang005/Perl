use DDP;

# @ERROR

if (__PACKAGE__ == "main") {
    my $list = [qw(type, value, when)];
    p $list;
    foreach my $elem (0..$#list) {
        ...
    }
    p $list;
}