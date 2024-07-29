BEGIN { push @INC, '.' };

use Pegex::Parser;
use Pegex::Grammar;
use Pegex::Tree;
use Pegex::Input;
use YAML;
use Calculator;
use CalGrammar;
use DDP;

$grammar_text = "
expr: num PLUS num
num: /( DIGIT+ )/
";

# $grammar = Pegex::Grammar->new(text => $grammar_text);
$receiver = Pegex::Tree->new(); # AST

$grammar = CalGrammar->new();
# $receiver = Calculator->new();  # ACTION
$parser = Pegex::Parser->new(

    grammar => $grammar,
    receiver => $receiver,
);
# $input = Pegex::Input->new(string => '2+2');
# $input = Pegex::Input->new(string => '(2+2)-');
$input = Pegex::Input->new(string => '(2+2)');

print Dump $parser->parse($input);