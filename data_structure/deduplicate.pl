use DDP;
use List::MoreUtils ':all';

my $list = [qw(repeat repeat 1 2 3 repeat)];
p $list;
my $deduplicate = [uniq @$list];
p $deduplicate;

my $list1 = [qw(repeat repeat 1 2 3 repeat)];
my %ha;
my $deduplicate1 = [grep {++$ha{$_}<2} @$list1];
p $list1;
p $deduplicate1;