# @web: https://www.junmajinlong.com/perl/perl_arr_hash_funcs/

=head;
splice ARRAY
splice ARRAY,OFFSET
splice ARRAY,OFFSET,LENGTH
splice ARRAY,OFFSET,LENGTH,LIST
=cut;

use feature qw(say);
say "#####################################";
say "########### splice ARRAY ############";
say "#####################################";
# 1. 一个参数时，即 splice ARRAY，表示清空 ARRAY。
@arr = qw(perl py php shell);
@new_arr = splice @arr;
say "original arr: @arr";   # 输出：空
say "new arr: @new_arr";    # 输出原列表内容

# 如果 splice 在标量上下文，则返回最后一个被移除的元素：
@arr=qw(perl py php shell);
$new_arr=splice @arr;
say "last element: $new_arr";    # 输出：shell

say "#####################################";
say "######## splice ARRAY OFFSET ########";
say "#####################################";
# 2. 两个参数时，即 splice ARRAY,OFFSET，表示从 OFFSET 处开始删除元素直到结尾。
# 注意，OFFSET 可以是负数。
@arr=qw(perl py php shell);
#                ^2----^  delete
@new_arr=splice @arr,2;
say "original arr: @arr";   # 输出：perl py
say "new arr: @new_arr";    # 输出：php shell

# 如果 offset 为负数，则表示从后向前数第几个元素，-1 表示最后一个元素。
@arr=qw(perl py php shell);
#            ^-3-------^-1   delete
@new_arr=splice @arr,-3;
say "original arr: @arr";    # 输出：perl
say "new arr: @new_arr";     # 输出：py php shell

say "#####################################";
say "#### splice ARRAY OFFSET LENGTH #####";
say "#####################################";
# 3. 三个参数时，即 splice ARRAY,OFFSET,LENGTH，表示从 OFFSET 处开始向后删除 LENGTH 个元素。
# 注意，LENGTH 可以为负数，也可以为 0，它们都有奇效。
@arr=qw(perl py php shell ruby);
#                ^2---^ delete
@new_arr=splice @arr,2,2;
say "original arr: @arr";   # 输出：perl py ruby
say "new arr: @new_arr";    # 输出：php shell

# 如果 length 为负数 (假设为 - 3)，则表示从 offset 处开始删除，直到尾部还保留 - length 个元素 (-3 时，即表示尾部保留 3 个元素)。例如：
@arr=qw(perl py php shell ruby java c c++ js);
#                ^2-----------------^  -2   delete
@new_arr=splice @arr,2,-2;   # 从php开始删除，最后只保留c++和js两个元素
say "original arr: @arr";    # 输出：perl py c++ js
say "new arr: @new_arr";     # 输出：php shell ruby java c
# 如果正数 length 的长度超出了数组边界，则删除结尾。如果负数 length 超出了边界，也就是保留的数量比要删除的数量还要多，
# 这时保留优先级更高，也就是不会删除。例如，从某个位置开始删除，后面还有 2 个元素，但如果 length=-2，则这两个元素不会被删除。

say "#####################################";
say "## splice ARRAY OFFSET LENGTH LIST ##";
say "#####################################";
# 4. 表示将 LIST 插入到删除的位置，也就是替换数组的部分位置连续的元素。
@arr=qw(perl py php shell ruby);
#                ^----^ delete
@list=qw(java c c++);
@new_arr=splice @arr,2,2,@list;
say "original arr: @arr";   # 输出：perl py java c c++ ruby
say "new arr: @new_arr";    # 输出：php shell

# 如果想原地插入新元素，而不删除任何元素，可以将 length 设置为 0，它会将新列表插入到 offset 的位置。
@arr=qw(perl py php shell ruby);
#                2 ^ insert
@list=qw(java c c++);
@new_arr=splice @arr,2,0,@list;
say "original arr: @arr";   # 输出：perl py java c c++ php shell ruby
say "new arr: @new_arr";    # 输出：空
# 注意上面 php 在新插入元素的后面。