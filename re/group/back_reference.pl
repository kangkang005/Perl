# @web: https://www.junmajinlong.com/perl/perl_re/index.html

# 在基础正则中，使用括号可以对匹配的内容进行分组，这种行为称为分组捕获。
# 捕获后可以通过 \1 这种反向引用方式去引用 (访问) 保存在分组中的匹配结果。
"abc11ddabc11" =~ /([a-z]*)([0-9]*)dd\1\2/;
print "first group \\1: $1\n";
print "second group \\2: $2\n";

print "\n";

# 在 perl 中，还可以使用 \gN 的方式来反向引用分组
"abc11ddabc11" =~ /([a-z]*)([0-9]*)dd(\g1)(\g2)/;
print "first group \\1: $1\n";
print "second group \\2: $2\n";
print "third group \\3: $3\n";
print "fourth group \\4: $4\n";

"abc11ddabc11" =~ /([a-z]*)([0-9]*)dd\g{1}\g{2}/;
"abc11ddabc11" =~ /([a-z]*)([0-9]*)dd\g{-2}\g{-1}/;
=head
有两点需要注意：

这些分组可能捕获到的是空值 (比如那些允许匹配 0 次的量词)，但是整个匹配是成功的。这时候引用分组时，得到的结果也将是空值
当分组匹配失败的时候，\1 会在识别括号的时候重置，而 $1 仍保存上一次分组成功的值
=cut