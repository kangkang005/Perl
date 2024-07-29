# @web: https://www.junmajinlong.com/perl/perl_re/index.html

# 匿名捕获是指仅分组，不捕获。因为不捕获，所以无法使用反向引用，也不会将分组结果赋值给 $1 这种特殊变量。

$str = "xiaofang or longshuai";
if ($str =~ /(\w+) (?:or|and) (\w+)/){
    print "name1: $1, name2: $2\n";
}

# n 修饰符，它也表示非捕获仅分组行为。但它只对普通分组有效，
# 对命名分组无效。且因为它是修饰符，它会使所有的普通分组都变成非捕获模式。
$str = "xiaofang or longshuai";
if ($str =~ /(\w+) (or|and) (\w+)/n){
    print "name1: $1, name2: $2\n";
}
# 由于上面开启了 n 修饰符，使得 3 个普通分组括号都变成非捕获仅分组行为，
# 所以 \1 和 $1 都无法使用。除非正则中使用了命名分组。