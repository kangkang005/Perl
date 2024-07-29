use Parse::RecDescent;

# @web: https://www.perl.com/pub/2001/06/13/recdecent.html/

# Create and compile the source file
$parser = Parse::RecDescent->new(q(
startrule : day  month /\d+/
          { print "Day: $item{day} Month: $item{month} Date: $item[3]\n"; }


day : "Sat" | "Sun" | "Mon" | "Tue" | "Wed" | "Thu" | "Fri"


month : "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" |
        "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec"
));


# Test it on sample data
print "Valid date\n" if $parser->startrule("Thu Mar 31");
print "Invalid date\n" unless $parser->startrule("Jun 31 2000");