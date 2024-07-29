# @reference: <<learning perl>> chapter 16: Some Advanced Perl Techniques, Fancier List Utilities

# If you need to combine two or more lists, you can use mesh to create the large list that
# interweaves all of the elements, even if the small arrays are not the same length:

use List::MoreUtils qw(mesh);
my @abc = 'a' .. 'z';
my @numbers = 1 .. 20;
my @dinosaurs = qw( dino );
my @large_array = mesh @abc, @numbers, @dinosaurs;
print "@large_array\n";