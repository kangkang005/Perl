use List::MoreUtils qw(singleton);

my @x = singleton 1,1,2,2,3,4,5; # returns 3 4 5
print "@x\n";