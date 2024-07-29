use List::MoreUtils qw(natatime);
# deal with the list in groups of items
# natatime: N at a time

my @x = ('a' .. 'g');
my $it = natatime 3, @x;
while (my @vals = $it->()) {
    print "@vals\n";
}