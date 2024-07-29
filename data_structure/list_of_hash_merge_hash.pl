use DDP;

if (__PACKAGE__ == "main") {
    my $list_of_hash = [
        { type => "ram" ,
            when => "SD" },
        { value => 0.121 },
    ];

    my $hash = {map { %$_ } @$list_of_hash};
    p $hash;
}