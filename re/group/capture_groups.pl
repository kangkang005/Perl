# @web: https://perldoc.perl.org/perlre#Character-set-modifier-behavior-prior-to-Perl-5.14

$_ = "wei zheng wei wei zheng ";
#           ^
#        group 1
#               ^       ^
#               (   group 2   )
#               ^
#              group 3
if (m/
    (\w+\s+)        # group 1
    (               # group 2
        (\w+\s+)    # group 3
        \g{-1}      # backref to group 3
        \g{-3}      # backref to group 1
    )
/x) {
    print $1 . "\n";
    print $2 . "\n";
    print $3 . "\n";
    print $4 . "\n";
    print $5 . "\n";
}