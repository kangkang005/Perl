my $HoA = {
    wei => [0, 2, 4, 6],
    li  => [10, 20, 40],
};

my $last_index = $#{$HoA->{wei}};
my $last_elem  = $HoA->{wei}[$last_index];
print "last = $last_elem";