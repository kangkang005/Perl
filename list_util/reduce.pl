use List::Util qw(reduce sum);
# @web: https://www.junmajinlong.com/perl/perl_list_utils/

my $max = reduce { $a > $b ? $a : $b} qw(10 5 2 20 14);
print "\$max = $max\n";
my $sum = reduce { $a + $b } qw(10 5 2 20 14);
print "\$sum = $sum\n";
my $concat = reduce { $a . $b } qw(i am perl);
print "\$concat = $concat\n";
my $total_length = reduce {$a + length $b} 0, qw(i am perl);
print "\$total_length = $total_length\n";
$total_length = sum map {length} qw(i am perl);
print "\$total_length = $total_length\n";

=head;
如果 @list 是空列表，则 reduce 返回 undef，如果 @list 是只有一个元素的列表，则直接返回这个元素，不会评估 block。

为了编写健壮的 reduce ()，经常使用 reduce 的一种通用技巧：为了避免列表元素数量的不足，使用一个或多个额外的不影响结果的元素压入到目标列表中。例如：
reduce {BLOCK} 0,@list;
reduce {BLOCK} 1,@list;
reduce {BLOCK} undef,@list;
reduce {BLOCK} undef,undef,@list;
=cut;
my @list = ();  # 空列表
$sum = reduce { $a + $b } 0, @list;
print "\$sum = $sum\n";