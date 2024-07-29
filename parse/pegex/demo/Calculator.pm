package Calculator;
use base 'Pegex::Tree';

sub got_expr {
    my ($receiver, $data) = @_;
    my ($a, $b) = @$data;
    return $a + $b;
}
1;