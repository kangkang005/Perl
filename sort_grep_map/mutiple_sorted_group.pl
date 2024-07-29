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

# 先对gender排序，再不改变gender顺序，再对salary排序
sub by_gender {
    $a->{gender} cmp $b->{gender}
}

sub by_salary {
    $a->{salary} <=> $b->{salary}
}

print "name     gender      salary      performance\n";
foreach my $info (
            sort {by_gender or by_salary}
            grep {defined $_->{gender} and defined $_->{salary}}
            @$data) {
    print join("    ", @{$info}{qw(name gender salary performance)}) . "\n";
}