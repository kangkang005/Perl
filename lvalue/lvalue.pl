# @web: https://perldoc.perl.org/perlsub
my $val;
sub setter_getter : lvalue {
    $val;  # or:  return $val;
}

setter_getter() = 5;   # assigns to $val

print setter_getter();