use DDP;

if (__PACKAGE__ == "main") {
    my $hash = {
        type  => "ram",
        value => 0.121,
        when  => "SD",
    };

    my $list_of_hash = [map {{$_ => $hash->{$_}}} keys %$hash];
    p $list_of_hash;
}