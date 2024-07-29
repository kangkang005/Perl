use Parse::RecDescent;


$parser = Parse::RecDescent->new(q{
    # <autoaction:
    #   $#item==1 ? $item[1] : "$item[0]_node"->new(@item[1..$#item])
    # >

    expression: and_expr '||' expression    {shift @item; print "@item\n"}   | and_expr
    and_expr:   not_expr '&&' and_expr      {shift @item; print "@item\n"}   | not_expr
    not_expr:   '!' brack_expr              {shift @item; print "@item\n"}   | brack_expr
    brack_expr: '(' expression ')'          {shift @item; print "@item\n"}   | identifier
    identifier: /[a-z]+/i
    startrule : expression
});


$parser->startrule("wei || (zheng && kang)");