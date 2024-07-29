use List::Util qw(any);
# @web: https://www.junmajinlong.com/perl/perl_list_utils/

# "none" oppose to "any"

=head;
any 是 reduce 类的一个工具，用于判断列表中是否存在某个符合条件的元素，如果存在则立即退出。
它有点像 grep，但是它比 grep 在元素判断上更优化，因为 grep 总会迭代所有元素，而 any 在得到结果时会立即退出。
=cut;

my @strings = qw(i am perl);
if( any { length > 1 } @strings ) {
    # at least one string has more than 2 characters
    print "any matched!\n";
}
if( grep { length > 1 } @strings ) {
    # at least one string has more than 2 characters
    print "grep matched!\n";
}
# 前面说了，grep 判断的效率要低一些，不管元素是否存在，它总会迭代完列表所有元素才退出，而 any 在第一次判断存在的时候就退出。