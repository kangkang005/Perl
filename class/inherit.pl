# @web: https://www.runoob.com/perl/perl-object-oriented.html
{
    package MyClass;

    sub new {
        print "MyClass::new called\n";
        my $class = shift;
        my $self = {};
        return bless $self, $class;
    }

    sub MyMethod {
        print "MyClass::MyMethod called!\n";
    }
    1;
};

{
    package MySubClass;
    @ISA = qw( MyClass );
    sub new {
        print "MySubClass::new called\n";
        my $class = shift;            # 包名
        my $self = MyClass->new;     # 引用空哈希
        return bless $self, $class;
    }

    sub MyMethod {
        my $self = shift;
        $self->SUPER::MyMethod();
        print "   MySubClass::MyMethod called!\n";
    }
    1;
};

print " call MyClass method -->\n";
$myObject = MyClass->new();
$myObject->MyMethod();

print " call MySubClass method -->\n";
$myObject2 = MySubClass->new();
$myObject2->MyMethod();