use List::MoreUtils qw(insert_after_string);

my @list = qw/This is a list/;
insert_after_string "a", "longer" => @list;
print "@list";