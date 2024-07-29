sub mysub() {
    while(my $shifted=shift){
        print $shifted,"\n";
    }
}

&mysub(qw(a.txt b.txt c.txt));    # 将依次输出a.txt b.txt c.txt