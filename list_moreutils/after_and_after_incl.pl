use List::MoreUtils qw(after after_incl);

my @x = after { $_ == 5 } (1..9);       # returns 6, 7, 8, 9
print "@x\n";
@x = after_incl { $_ == 5 } (1..9);     # returns 5, 6, 7, 8, 9
print "@x\n";