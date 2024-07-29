use List::MoreUtils qw(first_index only_index last_index);

my $data = [
    {
        "name"        => "zhangsan",
        "gender"      => "man",
        "salary"      => 2000,
        "performance" => 200,
    },
    {
        "name"        => "lisi",
        "gender"      => "man",
        "salary"      => 4000,
        "performance" => 500,
    },
    {
        "name"        => "wangwu",
        "gender"      => "woman",
        "salary"      => 6000,
        "performance" => 100,
    },
    {
        "name"        => "zhaoliu",
        "gender"      => "man",
        "salary"      => 1000,
        "performance" => 3000,
    },
    {
        "name"        => "sunqi",
        "gender"      => "woman",
        "salary"      => 8000,
        "performance" => 1000,
    },
    {
        "name"        => "weiba",
        "gender"      => undef,
        "salary"      => undef,
        "performance" => 1000,
    },
];

my $first = first_index {$_->{performance} == 1000} @$data;
# "only_index" Returns -1 if either no such item or more than one of these has been found.
my $only  = only_index {$_->{performance} == 1000} @$data;
my $last  = last_index {$_->{performance} == 1000} @$data;
print "\$first_index = $first\n";
print "\$only_index = $only\n";
print "\$last_index = $last\n";