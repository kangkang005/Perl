use Data::Dumper;
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
];

sub by_salary {
    $a->{salary} <=> $b->{salary}
}

my @sort = sort by_salary @$data;
print Data::Dumper->Dump([$sort[0], $sort[-1]], [qw(min max)]);