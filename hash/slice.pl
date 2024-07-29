# @reference: <<learning perl>> chapter 16: Some Advanced Perl Techniques

use Data::Dumper;
my %score = (
    wei => 100,
    li => 20,
    zhao => 30,
    xing => 60,
);

my @two = @score{qw(zhao xing)};
print "@two\n";
my @three_name = qw(wei li zhao);
my @three = @score{@three_name};
print "@three\n";

# assign
my @new_name = qw(cai fu);
@score{@new_name} = qw(70 80);
print Dumper \%score;

# map create hash
my %new_hash = map {$_ => $score{$_}} @new_name;
print Dumper \%new_hash;

# Key-Value Slices
# use v5.20;
my @found_name = qw(zhao cai);
my %found_hash = %score{@found_name};
print Dumper \%found_hash;