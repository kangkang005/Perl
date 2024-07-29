# use Data::Printer;
#  or
use DDP;

=head
colored & full-featured pretty print of Perl data structures and objects
=cut;

my $data = {
    "key2" => {
        "key11" => "value1",
    },
    "key1" => [1, 2, 3],
};

if (__PACKAGE__ == "main") {
    p $data;
}