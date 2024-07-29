# @web: https://www.cnblogs.com/f-ck-need-u/p/9733283.html

sub java_learn {
    print "Learning Java now\n";
}
sub perl_learn {
    print "Learning Perl now\n";
}
sub python_learn {
    print "Learing Python now\n";
}

%sub_hash = (
    "javaer"   => \&java_learn,
    "perler"   => \&perl_learn,
    "pythoner" => \&python_learn,
);

while(my ($who,$sub)=each %sub_hash){
    print "$who is learning\n";
    $sub->();
}

print "\n";
# or

%sub_hash = (
    "javaer" => sub {
        print "Learning Java now\n";
    },
    "perler" => sub {
        print "Learning Perl now\n";
    },
    "pythoner" => sub {
        print "Learning Python now\n";
    },
);

while( my($who,$sub) = each %sub_hash ){
    print "$who is learning\n";
    $sub->();
}