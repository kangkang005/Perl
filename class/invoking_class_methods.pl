{
    package Class;
    sub new {
        my $class = shift;
        my $self = {};
        print "Create class";
        return bless $self, $class;
    }
    1;
}

my $class_name = "Class";
$class_name->new();