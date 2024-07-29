my $string = "foobar";
if ($string =~ /foo(?#here is comment)bar/) {
    print "match";
}