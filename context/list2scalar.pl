# @web: https://www.junmajinlong.com/perl/perl_context/

my @arr = qw(perl python shell);
my $sorted = sort @arr;         # 返回undef
my $reversed = reverse @arr;    # perlpythonshell-->llehsnohtyplrep
print $sorted,"\n";
print $reversed,"\n";

@arr = qw(a b c d);
# 将数组赋值给标量变量，得到的是数组的长度 (元素个数)
my $x = @arr;           # 结果：$x=4
print $x . "\n";
# 将列表赋值给标量变量，得到的是最后一个元素，除了最后一个元素外，其它元素都被丢弃，也就是放进了 void context。
my $y = qw(a b c d);    # 结果：$y=d，开启了warnings的情况下会警告
print $y . "\n";
($y) = qw(a b c d);  # 结果：$y=d，不会警告
print $y . "\n";
my ($a,$b,$c,$d) = qw(a b c d);  # 结果：$a=a,$b=b,$c=c,$d=d