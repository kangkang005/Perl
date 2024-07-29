#!/usr/local/bin/perl -w

=pod
T       1.0E12
G       1.0E9
MEG     1.0E6
X       1.0E6
K       1.0E3
M       1.0E-3
MIL     2.54E-5 (i.e. 1/1000 inch)
U       1.0E-6
N       1.0E-9
P       1.0E-12
F       1.0E-15
A       1.0E-18
=cut

# use Number::Spice qw(:convert split_spice_number);
use Number::Spice qw(:all);
use feature qw(say);

say spice_to_number('5u');      # 5E-6
say spice_to_number('1.0e4k');  # 1.0E7

say number_to_spice(1.0e12); # 1T
say number_to_spice(1.0e-2); # 10M (i.e. milli, not mega!)

print "@{[split_spice_number('50uV')]}\n";

say suffix_value("u");
say suffix_value("meg");

# Converts a spice number to its shortest form by invoking spice_to_number() and number_to_spice().
say normalize_spice_number("5uV");
say normalize_spice_number(1.0e12);
say normalize_spice_number(1.0e-2);

say is_spice_number("w5d");
say is_spice_number("5u");

say $RE_NUMBER;
say $RE_SPICE_SUFFIX;
say $RE_SPICE_NUMBER;