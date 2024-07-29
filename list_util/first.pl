use List::Util qw(first);

# 迭代 list 中的每个元素，返回第一个应用于 BLOCK 返回 true 的元素。
# 注意，只要发现了一个满足条件的元素，就立即停止迭代，这和 any () 是类似的。

my @list  = (undef, undef, "first", "second");
# 返回list中第一个已定义的元素
my $first = first {defined($_)} @list;
print $first, "\n";

# 判断list中是否存在某个元素
if (first { $_ eq "first" } @list) {
    print "matched!";
}