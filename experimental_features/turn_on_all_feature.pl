# @reference: <<learning perl>> Appendix D: Experimental Features, Don’t Rely on Experimental Features

=head;
Feature         Introduced in   Experimental    Stable in       Documented in       Covered in
array_base      v5.10                           v5.10           perlvar
bitwise         v5.22                           5.28            perlop              Chapter 12
current_sub     v5.16                           v5.20           perlsub
declared_refs   v5.26           ✓                              perlref
evalbytes       v5.16                           v5.20           perlfunc
fc              v5.16                           v5.20           perlfunc
isa             v5.32           ✓                              perlfunc
lexical_subs    v5.18                           5.26            perlsub
postderef       v5.20                           v5.24           perlref
postderef_qq    v5.20                           v5.24           perlref
refaliasing     v5.22           ✓                              perlref
regex_sets      v5.18           ✓                              perlrecharclass
say             v5.10                           v5.10           perlfunc            Chapter 5
signatures      v5.20           ✓                              perlsub             Chapter 4
state           v5.10                           v5.10           perlfunc, perlsub   Chapter 4
switch          v5.10           ✓                              perlsyn
try-catch       v5.34           ✓                              perlsyn
unicode_eval    v5.16                                           perlfunc
unicode_strings v5.12                                           perlunicode
vlb             v5.30           ✓                              perlre
=cut;

use feature qw(:all);
no warnings "experimental::signatures";

sub f($num1, $num2) {
  return $num1 + $num2;
}
say f(3, 5);