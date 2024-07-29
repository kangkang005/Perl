my @arr   = (11, 22, 33, 44, 55);
my @slice = @arr[0..2, 4];
print "@slice\n";

@slice = @arr[$#arr-3..$#arr];
print "@slice\n";