# @web: https://perl-book.junmajinlong.com/ch3/7_op_list.html
use DDP;

# 注意，Perl map 不是完全等量映射，不一定会返回和原列表元素数量相同的列表。
# 特别地，如果语句块中返回空列表 ()，相当于没有向返回列表中追加元素。例如：
my @arr = (11,22,33,44,55);
# @evens = (undef,22,undef,44,undef)
my @evens = map {$_ if $_%2==0} @arr;
p @evens;

# @odd = (22,44)
my @odd = map {$_%2==1 ? $_ : ()} @arr;
# 等价于 map {$_} grep {$_%2==1} @arr;
p @odd;