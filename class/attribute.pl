{
    package Class;
    sub new {
        my $invocant = shift;
        my $class = ref $invocant || $invocant;
        my $self = {
            name => "li",
            @_,    # rest paramter as attribute and overwrite previous attribute
        };
        print $self->{name} . "\n" if exists $self->{name};
        print $self->{id} . "\n" if exists $self->{id};
        return bless $self, $class;
    }
    1;
}

my $cls = Class->new(name=>"wei", id=>1212);