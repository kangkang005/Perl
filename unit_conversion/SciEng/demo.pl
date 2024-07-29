#!/usr/local/bin/perl -w

use strict;
use Convert::SciEng;

# Creates and returns a new Number::SI object of the appropiate style, 'cs' or 'si' or 'spice'. The styles aren't case sensitive
my $c = Convert::SciEng->new('spice');
my $s = Convert::SciEng->new('si');

print "Scalar\n";
print $c->unfix('2.34u'), "\n\n";

print "Array\n";
print join "\n", $c->unfix(qw( 30.6k  10x  0.03456m  123n 45o)), "\n";

##Note, default format is 5.5g
print "Default format is %5.5g\n";
print join "\n", $c->fix(qw( 35e5 0.123e-4 200e3 )), "";
$c->format('%8.2f');    # Sets the format of number converter TO fix to be FORMAT. FORMAT is any valid format to sprintf, like '%5.5g' or '%6.4e'. The default format is '%5.5g'.
print "Change the format is %8.2g\n";
# Convert a number to scientific notation with fixes. Returns a string in the format given to it with the fix appended to the end. Also works with arrays, with an array of strings being returned.
print join "\n", $c->fix(qw( 35e5 0.123e-4 200e3 )), "";

print "Check out the SI conversion\n";
# Convert a string from scientific notation. Returns a number in exponential format. Also works with arrays, with an array of numbers being returned.
print join "\n", $s->unfix(qw( 30.6K  10M  0.03456m  123n 45o)), "";