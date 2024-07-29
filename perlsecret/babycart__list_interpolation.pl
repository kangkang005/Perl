# @web: https://metacpan.org/dist/perlsecret/view/lib/perlsecret.pod

my $employee = {
    "wei"  => 1,
    "li"   => 2,
    "chen" => 3,
};

print "employee are @{[ sort keys %$employee ]}\n";