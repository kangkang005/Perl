use DDP;
# Include these two lines if your code is intended to run under Perl
# versions earlier than 5.26.
no warnings "experimental::lexical_subs";
use feature qw(current_sub lexical_subs);

# @web: https://perldoc.perl.org/perlsub

my $list = [1, 2, [3, [4, 5]], 6];

sub flatten {
    my $arr    = shift;
    my $result = [];

    my sub help {
        my $elem = shift;
        if(ref $elem and ref $elem == "ARRAY") {
            foreach (@$elem) {
                __SUB__->($_);
            }
        } else {
            push @$result, $elem;
        }
    };
    help($arr);
    return $result;
}

my $flatten = flatten($list);
p $flatten;