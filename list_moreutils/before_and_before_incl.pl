use List::MoreUtils qw(before before_incl);

my @x = before { $_ == 5 } (1..9);      # returns 1, 2, 3, 4
print "@x\n";
@x = before_incl { $_ == 5 } (1..9);    # returns 1, 2, 3, 4, 5
print "@x\n";