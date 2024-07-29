# @web: https://www.junmajinlong.com/perl/perl_context/

# 有时候如果想要强制指定标量上下文，可以使用伪函数 scalar 进行强制切换，它会告诉 perl 这里要切换到标量上下文。

my @arr = qw(perl python shell);
print "How many subject do you learn?\n";
print "I learn ", @arr, " subjects!\n";         # 错误，这里会输出课程名称
print "I learn ", scalar @arr, " subjects!\n";  # 正确，这里输出课程数量

=head
另一种切换为标量上下文的方式是使用 ~~，这是两个比特位取反操作，
因为比特位操作环境是标量上下文，两次位取反相当于不做任何操作，
所以将环境变成了标量上下文。这在写精简程序时可能会用上，
而且因为 ~~ 是符号，可以和函数之间省略空格分隔符：
=cut;

@arr = qw(Shell Perl Python);
print ~~@arr;
print "\n";
print~~@arr;
print "\n";

=head;
Perl 中赋值操作总是先评估右边，所以上面等价于 $var = (() = expr)。
() = expr 表示转换成列表上下文，使得 expr 以列表上下文的环境工作。
最后的赋值操作，由于左边是 $var，会将列表转换成标量上下文。
=cut;

my $var = () = qw(10 20 30 40);
print $var;

=head;
(如果不理解，暂时跳过) 这种技巧比较常见的是 $num = () = <>，
因为 <> 在不同上下文环境下工作的方式是不一样的，
这个表达式表示以列表上下文环境读取所有行，然后赋值给标量，
所以赋值给标量的是列表的元素个数，也就是文件的行数。
=cut;

my $num = () = <>;
print $num;