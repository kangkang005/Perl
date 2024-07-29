# @web: https://www.cnblogs.com/f-ck-need-u/p/9781455.html

=pod # 这里表示pod文档段落从此处开始，下面属于pod文档
=head1 Heading Text     # 标题
=head2 Heading Text
=head3 Heading Text
=head4 Heading Text
=head5 Heading Text
=head6 Heading Text

# 其中列表由 =over NUM 开始，NUM 表示列表的缩进程度，由 =back 结束列表。有无序列表和有序列表两种形式。
=over indentlevel   # 列表
=item stuff
=back

=begin format   # 格式，见官方手册
=end format

# for example
=begin html
<hr> <img src="thang.png">
<p> This is a raw HTML paragraph </p>
=end html

=for format text...

# for example
=for html
<hr> <img src="thang.png">
<p> This is a raw HTML paragraph </p>

=encoding type  # 编码类型
=encoding UTF-8
=cut # 这里表示pod文档段落到此结束，下面不属于pod文档