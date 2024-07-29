BEGIN { push @INC, '.' };

use Pegex;
use Pegex::Tree;
use YAML;
use Calculator;

$grammar = "
expr: num PLUS num
num: /( DIGIT+ )/
";

print Dump pegex($grammar, 'Calculator')->parse('2+2');
# print Dump pegex($grammar, 'Pegex::Tree::Wrap')->parse('2+2');    # wrap to tree, default
# print Dump pegex($grammar, 'Pegex::Tree')->parse('2+2');      # flatten to leaf