# @web: https://perldoc.perl.org/perlre#Character-set-modifier-behavior-prior-to-Perl-5.14

# 在数字电路验证中，我们经常需要处理各种 Hierarchy，在把特定的 Hierarchy 作为 Pattern 进行匹配或者筛选是，通常需要把 [0]、. 等元字符做转义.
my $string = "CKA[1][2]";
my $substring = "A[1]";
if ($string =~ /CK\Q$substring\E\[2\]/) {
    print "match";
}

# or
print "\n";

my $quoted_substring = quotemeta($substring);
if ($string =~ /CK$quoted_substring\[2\]/) {
    print "match";
}