use List::MoreUtils qw(arrayify);

# flatten list

my $a = [1, [[2], 3], 4, [5 , 2], 6, [7], 8, 9];
my @l = arrayify @$a;         # returns 1, 2, 3, 4, 5, 6, 7, 8, 9
print "@l\n";