# @web: https://perl-book.junmajinlong.com/ch5/7_modifiers_statements.html

=head;
需要区分 do 语句块和纯语句块：

1. 它们都只执行一次
2. 它们都有自己的代码块作用域
3. do 语句块相当于匿名函数，有返回值，它不是循环结构，语句块中不能使用 last、redo、next
4. 纯语句块没有返回值 (因此不能赋值给变量)，它是只执行一次的循环结构，语句块中可以使用 last、redo、next
=cut;

use feature qw(:all);

my $gender = "female";
my $name;
if ( $gender eq "male" ) {
    $name = "Junmajinlong";
} elsif ( $gender eq "female" ) {
    $name = "Gaoxiaofang";
} else {
    $name = "RenYao";
}
say $name;

# 将使用 if-elsif-else 结构进行赋值的行为改写成 do。以下是 if-elsif-else 结构：
$name = do {
    if    ( $gender eq "male" )   { "Junmajinlong" }
    elsif ( $gender eq "female" ) { "Gaoxiaofang" }
    else                          { "RenYao" }
};    # 注意结尾的分号
say $name;

# 使用 ? : 三目运算符改写do
$name = $gender eq "male" ?  "Junmajinlong" :
        $gender eq "female" ?  "Gaoxiaofang" :
        "RenYao";
say $name;