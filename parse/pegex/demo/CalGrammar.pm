package CalGrammar;
use Pegex::Base;
extends 'Pegex::Grammar';

has text => q{
    expr: num PLUS num
    num : /( DIGIT+ )/
};