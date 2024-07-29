#!/usr/bin/perl -w

# 如果使用这种方法，可以直接把颜色属性放在要输出的问题前面，从而简化输出步骤。
use Term::ANSIColor qw(:constants);
# 如果你不想在每条打印语句后面加上 RESET 的话，你可以直接把 $Term::ANSIColor::AUTORESET 的值设为 true。
# 这样每次打印完字符，只要你的属性值之间没有逗号，系统将自动帮你清除掉颜色属性。
$Term::ANSIColor::AUTORESET = 1;

my @colors = qw(
    CLEAR RESET BOLD DARK UNDERLINE
    UNDERSCORE BLINK REVERSE CONCEALED
    BLACK RED GREEN YELLOW BLUE
    MAGENTA CYAN WHITE ON_BLACK
    ON_RED ON_GREEN ON_YELLOW ON_BLUE
    ON_MAGENTA ON_CYAN ON_WHITE
);
for my $color (@colors)
{
    print eval $color, "$color";
    print CLEAR, "\n";
}
print BOLD BLUE "This text is in bold blue.\n";
print "This text is normal.\n";