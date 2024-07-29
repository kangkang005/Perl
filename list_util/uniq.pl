use List::Util qw(uniq);

my @tsuniq = qw(ab ab AB 1 1 2 2.0 3 );
my @subset = uniq @tsuniq;  # ab AB 1 2 2.0 3
my $count = uniq @tsuniq;   # 6

print join(" ", @subset), "\n";
print $count, "\n";