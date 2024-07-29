# @web: https://perldoc.perl.org/perlobj
{
    package Init;
    sub new {
        my $class = shift;
        my $self = {};
        bless $self, $class;
        # <----- init begin ----->
        $self->_initialize();
        print $self->{_msg};
        # <----- init end ----->
        return $self;
    }
    sub _initialize {
        my $self = shift;
        $self->{_msg} = "init done";
    }
    1;
}

Init->new();