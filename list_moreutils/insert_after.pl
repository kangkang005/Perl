use List::MoreUtils qw(insert_after);

my @list = qw/This is a list/;
insert_after { $_ eq "a" } "longer" => @list;
print "@list";