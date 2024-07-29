# @web: https://www.junmajinlong.com/perl/perl_re/index.html

=head;
命名捕获是指将捕获到的内容放进分组，这个分组是有名称的分组，所以后面可以使用分组名去引用已捕获进这个分组的内容。除此之外，和普通分组并无区别。

当要进行命名捕获时，使用 (?<NAME>) 的方式替代以前的分组括号 () 即可。例如，要匹配 abc 并将其分组，以前普通分组的方式是 (abc)，如果将其放进命名为 name1 的分组中：(?<name1>abc)。

当使用命名捕获的时候，要在正则内部引用这个命名捕获，除了可以使用序号类的绝对引用 (如 \1 或 \g1 或 \g{1})，还可以使用以下任意一种按名称引用方式：

\g{NAME}
\k{NAME}
\k<NAME>
\k'NAME'
如果要在正则外部引用这个命名捕获，除了可以使用序号类的绝对应用 (如 $1)，还可以使用 $+{NAME} 的方式。

实际上，后一种引用方式的本质是 perl 将命名捕获的内容放进了一个名为 %+ 的特殊 hash 类型中，所以可以使用 $+{NAME} 的方式引用，如果你不知道这一点，那就无视与此相关的内容即可，不过都很简单，一看就懂。
=cut;
$str = "ma xiaofang or ma longshuai";
if ($str =~ /
            (?<firstname>\w+)\s     # firstname -> ma
            (?<name1>\w+)\s         # name1 -> xiaofang
            (?:or|and)\s            # group only, no capture
            \g1\s                   # \g1 -> ma
            (?<name2>\w+)           # name2 -> longshuai
            /x) {
    print "\$1 \$2 \$3\n";
    print "$1\n";
    print "$2\n";
    print "$3\n";
    print "\n";
    # 或者指定名称来引用
    print "\$+{firstname} \$+{name1} \$+{name2}\n";
    print "$+{firstname}\n$+{name1}\n$+{name2}\n";
}

=head
其中上述代码中的 \g1 还可以替换为 \1、\g{firstname}、\k{firstname} 或 \k<firstname>。

通过使用命名捕获，可以无视序号，直接使用名称即可准确引用。
=cut;