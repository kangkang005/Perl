# @web: https://www.cnblogs.com/f-ck-need-u/p/9780625.html

=head;
(1). 程序编译期间
(2). 程序执行期间
(3). 程序执行结束但还未退出期间
=cut;

=head;
* BEGIN 块是在程序编译期间执行的，也就是上面的步骤 (1) 所在期间
* 即使程序中出现了语法错误，BEGIN 块也会执行
* 如果出现了多个 BEGIN 块，则按照 FIFO (first in first out) 的方式输出，也就是从上到下的顺序
* BEGIN 块常用于perl一行式，用于声明变量以及赋初值
perl -lne 'BEGIN{$linenum=1}; print $linenum++.$_ if /param/' fullspeed.param
=cut;

use strict;
use warnings;
BEGIN {
    print "This is the first BEGIN block\n";
}

print "The program is running\n";

BEGIN {
    print "This is the second BEGIN block\n";
}

=head;
END 块是在程序执行结束，但退出前执行的，也就是上面的步骤 (3) 所在期间。

* 当触发了 die 的时候，它们也会执行
* 但可以通过信号来忽略 END
* 它们的执行顺序是 LIFO (last in first out)，即从下往上输出
* END 常用来做清理、善后操作
=cut;

END {
    print "This is the first END block\n";
}

END {
    print "This is the second END block\n";
}