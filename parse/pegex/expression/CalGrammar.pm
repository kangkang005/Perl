package CalGrammar;
use Pegex::Base;
extends 'Pegex::Grammar';

has text => q{
    expr  : term (addop term)*
    addop : '+' | '-'
    term  : factor (mulop factor)*
    mulop : '*' | '/'
    factor: '(' expr ')' | num
    num   : /( DIGIT+ )/
};

# has text => q{
#     expr  : term (addop term)*
#     addop : '+' | '-'
#     term  : factor (mulop factor)*
#     mulop : '*' | '/'
#     factor: '(' expr ')' | num
#     num   : /( DIGIT+ )/
# };

# has text => q{
#     expr: term | expr '+' term | expr '-' term
#     term: factor | term '*' factor | term '/' factor
#     factor: '(' expr ')' | num
#     num : /( DIGIT+ )/
# };

# has text => q{
#     expr  : expr addop term | term
#     addop : '+' | '-'
#     term  : term mulop factor | factor
#     mulop : '*' | '/'
#     factor: '(' expr ')' | num
#     num   : /( DIGIT+ )/
# };