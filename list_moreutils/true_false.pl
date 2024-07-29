use List::MoreUtils qw(true false);

# Counts the number of elements in LIST for which the criterion in BLOCK is true/false.
my @list = (1, 2, undef, 3, undef, 4);
printf "%i item(s) are defined\n", true { defined($_) } @list;
printf "%i item(s) are not defined\n", false { defined($_) } @list;