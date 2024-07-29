# @web: https://www.runoob.com/perl/perl-object-oriented.html

{
    package Person;
    sub new {
        my $class = shift;
        my $self = {
            _firstName => shift,
            _lastName  => shift,
            _ssn       => shift,
        };
        print " firstName:  $self->{_firstName}\n";
        print " lastName:   $self->{_lastName}\n";
        print " ssn:        $self->{_ssn}\n";
        bless $self, $class;
        return $self;
    }
    sub setFirstName {
        my ( $self, $firstName ) = @_;
        $self->{_firstName} = $firstName if defined($firstName);
        return $self->{_firstName};
    }

    sub getFirstName {
        my( $self ) = @_;
        return $self->{_firstName};
    }
    1;
}

{
    package Employee;
    # use Person;
    use strict;
    our @ISA = qw(Person);

    sub new {
        my ($class) = @_;

        my $self = $class->SUPER::new( $_[1], $_[2], $_[3] );
        $self->{_id}    = undef;
        $self->{_title} = undef;
        bless $self, $class;
        return $self;
    }

    # overwrite
    sub getFirstName {
        my( $self ) = @_;
        print " subclass function \n";
        return $self->{_firstName};
    }

    # add
    sub setLastName {
        my ( $self, $lastName ) = @_;
        $self->{_lastName} = $lastName if defined($lastName);
        return $self->{_lastName};
    }

    sub getLastName {
        my( $self ) = @_;
        return $self->{_lastName};
    }
    1;
}

# use Employee;
$object = new Employee( " ming ", " wang ", 23234345);
$firstName = $object->getFirstName();
print $firstName . "\n";

$lastName = $object->getLastName();
print $lastName . "\n";