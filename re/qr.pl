# @web: https://www.junmajinlong.com/perl/perl_re/index.html
# qr// 创建正则对象
$str="hello worlds gaoxiaofang";

# 直接作为正则表达式
$str =~ qr/w.*d/;
print "$&\n";

# 保存为变量，再作为正则表达式
$pattern = qr/w.*d/;
$str =~ $pattern;    # (1)
$str =~ /$pattern/;  # (2)
print "$&\n";

# 保存为变量，作为正则表达式的一部分
$pattern = qr/w.*d/;
$str =~ /hel.* $pattern/;
print "$&\n";

print "\n";
# 还允许为这个正则对象设置修饰符，比如忽略大小写的匹配修饰符为 i，
# 这样在真正匹配的时候，就只有这一部分正则对象会忽略大小写，其余部分仍然区分大小写。
$str = "HELLO wORLDs gaoxiaofang";

$pattern = qr/w.*d/i;         # 忽略大小写

print "match1\n" if $str =~ /HEL.* $pattern/;   # 匹配成功，$pattern部分忽略大小写
print "match2\n" if $str =~ /hel.* $pattern/;   # 匹配失败
print "match3\n" if $str =~ /hel.* $pattern/i;  # 匹配成功，所有都忽略大小写