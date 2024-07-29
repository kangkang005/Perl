# @web: https://perl-book.junmajinlong.com/ch8/8_prototype.html#%E5%8E%9F%E5%9E%8B%E5%AD%90%E7%A8%8B%E5%BA%8F%E5%92%8C%E5%87%BD%E6%95%B0%E7%AD%BE%E5%90%8D
use feature qw(say);

=head;
& 表示该参数是一个匿名子程序或子程序引用，当它作为第一个参数时，
可省略 sub 关键字以及该参数后的逗号分隔符。这是一个非常有趣的语法，
甚至它可以实现新的 Perl 语法，比如可以实现类似于 grep {} @arr 的语句块用法，
在 perldoc persub 中也给出了通过该功能实现 try{}catch{} 语法
=cut;

# 类似于map的功能
sub f(&@){
  my $sub_ref = shift;
  my @arr=();
  for (@_){ push @arr, $sub_ref->($_); }
  return @arr;
}

my @arr = f { $_ * 2 } 11,22,33;
say "@arr";