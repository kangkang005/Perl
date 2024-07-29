use DDP;

my $str = "0:1:2:3:4:5";
my $last_n_element = [sub {@_[2..$#_]}->(split /:/, $str)];
p $str;
print "get last n element after split\n";
p $last_n_element;