# @web: https://www.junmajinlong.com/perl/perl_arr_hash_funcs/

sub mysub() {
    while(my $poped=pop){
        print $poped,"\n";
    }
}

&mysub(qw(a.txt b.txt c.txt));    # 将依次输出c.txt b.txt a.txt