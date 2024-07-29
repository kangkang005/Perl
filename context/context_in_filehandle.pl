# @web: https://www.junmajinlong.com/perl/perl_context/

open FILE, "<context_in_filehandle.pl";
chomp(my @lines = <FILE>);
print "@lines\n";