# @web: https://perl-book.junmajinlong.com/ch5/6_loop_control.html
use feature qw(say);

while (print ">> ") {  # 无限循环，输出提示符
  # 读取终端输入，去除行尾换行符
  chomp ($_ = <>);
  # 当输入q或者exit并回车时，退出循环
  /^q$/i and last;
  # 执行输入的perl代码，并输出执行代码的返回值
  say "=> ", (eval $_) // "undef";
}