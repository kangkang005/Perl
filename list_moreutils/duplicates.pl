use List::MoreUtils qw(duplicates);

my @y = duplicates 1,1,2,4,7,2,3,4,6,9; #returns 1,2,4
print "@y\n";