use strict;
use Parse::RecDescent;
use Data::Dumper;

=pod
@web: https://www.perl.com/pub/2001/06/13/recdecent.html/

When writing your own grammars for Parse::RecDescent, one important rule to
keep in mind is that a rule can never have itself as the first term. This
makes rules such as statement : statement ";" statements illegal. This sort
of grammar is called “left-recursive” because a rule in the grammar expands to its left side.

Left-recursive grammars can usually be rewritten to right-recursive,
which will parse cleanly under Parse::RecDescent, but there are classes
of grammars thatcant be rewritten to be right-recursive. If a grammar can’t
be done in Parse::RecDescent, then something like Parse::Yapp may be more appropriate.
It’s also possible to coerce yacc into generating a perl skeleton, supposedly.
=cut

use vars qw(%VARIABLE);


# Enable warnings within the Parse::RecDescent module.


$::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
$::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
$::RD_HINT   = 1; # Give out hints to help fix problems.


my $grammar = <<'_EOGRAMMAR_';


# Terminals (macros that can't expand further)
#


OP       : m([-+*/%])      # Mathematical operators
INTEGER  : /[-+]?\d+/      # Signed integers
VARIABLE : /\w[a-z0-9_]*/i # Variable


expression : INTEGER OP expression
            { return main::expression(@item) }
            | VARIABLE OP expression
            { return main::expression(@item) }
            | INTEGER
            | VARIABLE
            { return $main::VARIABLE{$item{VARIABLE}} }


print_instruction  : /print/i expression
                    { print $item{expression}."\n" }
assign_instruction : VARIABLE "=" expression
                    { $main::VARIABLE{$item{VARIABLE}} = $item{expression} }


instruction : print_instruction
            | assign_instruction


startrule: instruction(s /;/)

# same as:
#
# instructions : instruction ";" instructions
#             | instruction
# startrule : instructions

_EOGRAMMAR_


sub expression {
    shift;
    my ($lhs,$op,$rhs) = @_;
    $lhs = $VARIABLE{$lhs} if $lhs=~/[^-+0-9]/;
    return eval "$lhs $op $rhs";
}


my $parser = Parse::RecDescent->new($grammar);


print "a=2\n";             $parser->startrule("a=2");
print "a=1+3\n";           $parser->startrule("a=1+3");
print "print 5*7\n";       $parser->startrule("print 5*7");
print "print 2/4\n";       $parser->startrule("print 2/4");
print "print 2+2/4\n";     $parser->startrule("print 2+2/4");
print "print 2+-2/4\n";    $parser->startrule("print 2+-2/4");
print "a = 5 ; print a\n"; $parser->startrule("a = 5 ; print a");