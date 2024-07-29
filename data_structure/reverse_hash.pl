use DDP;

if (__PACKAGE__ == "main") {
    my $hash = {
        type  => "ram",
        value => 0.121,
        when  => "SD",
    };

    my $reverse_hash = {reverse %$hash};
    p $reverse_hash;
}