use Data::Dumper;
my $score = [
    {
        wei => 100,
        li => 20,
        zhao => 30,
        xing => 60,
    },
    {
        cai => 70,
        xu => 70,
    },
];

my $found_name = [qw(li wei)];
my @found_score = @{$score->[0]}{@$found_name};
print "@found_score\n";

# assign
@{$score->[1]}{@$found_name} = qw(12 32);
print Dumper $score;

# Key-Value Slices
# use v5.20;
my $new_hash = {%{$score->[0]}{@$found_name}};
print Dumper $new_hash;