# @web: https://perldoc.perl.org/perlobj

{
    package File;

    sub new {
        my $class = shift;
        my ( $path, $data ) = @_;

        my $self = bless {
            path => $path,
            data => $data,
        }, $class;

        return $self;
    }

    sub print {
        my $self = shift;
        print $self->{path} . "\n";
        print $self->{data} . "\n";
    }
    1;
}

my $file = File->new("/path", "content");
$file->print();