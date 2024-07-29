# @web: https://perldoc.perl.org/perlre#Character-set-modifier-behavior-prior-to-Perl-5.14

my $string = 'i am perl';
pos($string) = 0;
while ($string =~ /(\w+)/g) {
    print $1 . "\n";
}