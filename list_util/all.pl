use List::Util qw(all);

# "all" oppose to "notall"

my @strings = qw(he am perl);
if( all { length > 1 } @strings ) {
    # all strings have more than 1 characters
    print "all more than 1!\n";
}
if( all { length > 2 } @strings ) {
    # all strings have more than 2 characters
    print "all more than 2!\n";
}