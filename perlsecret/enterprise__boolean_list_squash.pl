# @web: https://metacpan.org/dist/perlsecret/view/lib/perlsecret.pod

use DDP;

my %cupboard = (
    apples   => 1,
    bananas  => 10,
    cherries => 30,
    gin      => 1,
);

my @shopping_list = ('bread', 'milk');
push @shopping_list, 'apples'   if $cupboard{apples} < 2;       # yes
push @shopping_list, 'bananas'  if $cupboard{bananas} < 2;      # no
push @shopping_list, 'cherries' if $cupboard{cherries} < 20;    # no
push @shopping_list, 'tonic'    if $cupboard{gin};              # yes

my @enterprise_shopping_list = (
    'bread',
    'milk',
   ('apples'   )x!! ( $cupboard{apples} < 2 ),          # push
   ('bananas'  )x!! ( $cupboard{bananas} < 2 ),         # pop
   ('cherries' )x!! ( $cupboard{cherries} < 20 ),       # pop
   ('tonic'    )x!! $cupboard{gin},                     # push
);

p @shopping_list;
p @enterprise_shopping_list;