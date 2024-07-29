use DDP;

my $raw_hh = {
    "type" => "flash",
    when  => "SD",
};

my $replace_hh = {
    type  => "ram",
    value => 0.121,
};

my $merge_hh = {%$raw_hh, %$replace_hh};
p $raw_hh;
p $replace_hh;
print "after merge\n";
p $merge_hh;

print "overwrite raw data\n";
my $raw_hh = {%$raw_hh, %$replace_hh};
p $raw_hh;