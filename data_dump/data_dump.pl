use Data::Dump qw(dump);

=head
使用 Data::Dump 的 dump 方法，它输出时不会将输出结果赋值给标量变量，而是直接输出数据结构，有什么就输出什么
=cut;

my $data = {
    "key2" => {
        "key11" => "value1",
    },
    "key1" => [1, 2, 3],
};

if (__PACKAGE__ == "main") {
    print dump $data;
}