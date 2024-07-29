use DDP;
# @web: https://www.cnblogs.com/f-ck-need-u/p/9718238.html

{
    my $name = "longshuai";
    my $prov = "jiangxi";
}
# 出了语句块，上面两个my标记的变量就失效了

=head;
那么如何让 perl 知道大括号是用来构造匿名 hash 的，还是用来做一次性语句块的？大多数时候，Perl 根据上下文的环境会自动判断出来，但是有些时候无法判断，这时可以显式告诉 Perl，这是匿名 hash 的构造符号，还是一次性语句块的符号。

1. 大括号前面加上 + 符号，即 +{...}，表示这个大括号是用来构造匿名 hash 的
2. 大括号内部第一个语句前，多使用一个 ;，即 {;...}，表示这个大括号是一次性语句块
+ 还可以加在匿名数组的中括号前，以及 hash 引用变量、数组引用变量前，而不仅仅是匿名 hash 的大括号前，如 +$ref_hash、+[]、+$ref_arr。
=cut;

my $ref_hash = {   # 构造匿名hash，赋值给引用变量
    'longshuai'=> ['male',18,'jiangxi'],
    'wugui'    => ['male',20,'zhejiang'],
    'xiaofang' => ['female',19,'fujian'],
};
p @{+[qw(longshuai wugui)]};    # 匿名数组中括号前
p %{ +$ref_hash };              # hash引用变量前