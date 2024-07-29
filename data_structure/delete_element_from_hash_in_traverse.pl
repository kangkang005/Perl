use DDP;

# @ERROR

if (__PACKAGE__ == "main") {
    my $hash = {
        type  => "ram",
        value => 0.121,
        when  => "SD",
    };
    p $hash;
    foreach my $key (keys %$hash) {
        delete $hash->{$key} if $key == "value";
    }
    p $hash;
}