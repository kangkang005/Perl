# @web: https://perl-book.junmajinlong.com/ch3/7_op_list.html

# reverse 用于反转列表：在列表上下文中返回元素被反转后的列表，在标量上下文中，返回原始列表各元素组成的字符串的反转字符串。
my @arr1 = qw(aa bb cc dd);

print "@{[reverse @arr1]}\n";  # dd cc bb aa
print ~~(reverse @arr1);     # ddccbbaa，返回aabbccdd的反转