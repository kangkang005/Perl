use DDP;

my $list = [1, 2, [3, [4, 5]], 6];

sub flatten {
    my $arr    = shift;
    my $result = [];

    my $help; $help = sub {
        my $elem = shift;
        if(ref $elem and ref $elem == "ARRAY") {
            foreach (@$elem) {
                $help->($_);
            }
        } else {
            push @$result, $elem;
        }
    };
    $help->($arr);
    return $result;
}

my $flatten = flatten($list);
p $flatten;