# @web: https://perl-book.junmajinlong.com/ch3/7_op_list.html
use feature qw(:all);

# map 允许在一个迭代过程中保存多个元素到返回列表中。
my @name=qw(ma long shuai);
my @new_names=map {$_,$_ x 2} @name;
say "@new_names";  # ma mama long longlong shuai shuaishuai

# map 可以一次向返回列表中添加多个元素，因此可以每次迭代生成两个元素并将 map 返回值赋值给 hash：
@name=qw(ma long shuai gao xiao fang);
my %new_names = map {$_, $_ x 2} @name;

while (my ($key,$value) = each %new_names){
    say "$key --> $value";
}