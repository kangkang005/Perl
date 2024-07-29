package Calculator;
use base 'Pegex::Tree';
use DDP;

sub got_expr {
    my ($receiver, $data) = @_;
}

sub got_term {
    my ($receiver, $data) = @_;
}

sub got_factor {
    my ($receiver, $data) = @_;
}
1;