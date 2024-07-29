$_ = "FooBar";
$pattern1 = "(?i)foo";
$pattern2 = "(?i)bar";
if ( /${pattern1}${pattern2}/ ) {
    print "match";
}