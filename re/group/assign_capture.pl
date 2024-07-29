use DDP;
my $str = "ma xiaofang or ma longshuai";

my @captures = $str =~ /(\w+)\s+(\w+)\s+(\d+\s+)?(?<name>\w+)/;

p @captures;
print $+{name};