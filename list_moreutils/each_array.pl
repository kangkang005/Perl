use List::MoreUtils qw(each_array each_arrayref);

my @a = qw(1 2 3);
my @b = qw(a b c);
my @c = qw(A B C);
my $ea = each_array(@a, @b, @c);
while ( my ($a, $b, $c) = $ea->() ) {
    print "$a, $b, $c\n";
}

print "\n";

my $aref = [qw(1 2 3)];
my $bref = [qw(a b c)];
my $cref = [qw(A B C)];
$ea = each_arrayref($aref, $bref, $cref);
while ( my ($a, $b, $c) = $ea->() ) {
    print "$a, $b, $c\n";
}