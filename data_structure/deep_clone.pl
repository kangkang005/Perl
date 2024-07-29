use DDP;
use Storable 'dclone';

my $hash = {
    type  => "ram",
    value => 0.121,
    when  => "SD",
};

my $deepclone_hash = dclone $hash;
delete $deepclone_hash->{type};
p $hash;
print "after delete key:\n";
p $deepclone_hash;