use Data::Dumper;

# 可以设置为一个正整数，该整数指定我们不冒险进入结构的深度。
$Data::Dumper::Maxdepth = 1;
# 可以设置为字符串，该字符串指定哈希键和值之间的分隔符。默认值为：=>。
$Data::Dumper::Pair     = ":";
# 可以设置为布尔值以控制是否按排序顺序转储哈希键。
$Data::Dumper::Sortkeys = 1;
# 设置后，启用双引号表示字符串值。
$Data::Dumper::Useqq    = 1;
# 避免使用 $VAR{n} 名称，但是建议不要通过 eval 始终解析此类输出。
# $Data::Dumper::Terse    = 1;
my $data = {
    "key2" => {
        "key11" => "value1",
    },
    "key1" => [1, 2, 3],
};

my $arr = [
    'longshuai',
    'wugui',
    'fairy',
    'xiaofang'
];

if (__PACKAGE__ == "main") {
    # Dumper(<reference>)
    print Dumper $data;
    print Data::Dumper->Dump([$data, $arr], [qw(my_data my_arr)]);     # 第二个数组引用用来定义现实的变量名，而不是默认的 VAR
}