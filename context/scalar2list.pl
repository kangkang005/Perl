# @web: https://www.junmajinlong.com/perl/perl_context/
use DDP;

# 这种情况很简单，如果某个操作的返回结果是标量值，但却在列表上下文中，则直接生成一个包含此返回值的列表。
my @arr = 6 * 7;    # 结果：@arr=(42)
p @arr;
@arr = "hello".' '.'world';  # 结果：@arr=("hello world")
p @arr;