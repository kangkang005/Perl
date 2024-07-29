use Parse::Lex;
@token = (
  qw(
     ADDOP    [-+]
     LEFTP    [\(]
     RIGHTP   [\)]
     INTEGER  [1-9][0-9]*
     NEWLINE  \n
    ),
  qw(STRING),   [qw(" (?:[^"]+|"")* ")],
  qw(ERROR  .*), sub {
    die qq!can\'t analyze: "$_[1]"!;
  }
 );

# Parse::Lex->trace;  # Class method, print trace lex info, can output file if argument is filehandle
Parse::Lex->skip('\s*#(?s:.*)|\s+');  # skip comment (begin with #)
$lexer = Parse::Lex->new(@token);
$lexer->from(\*DATA);
# $lexer->every(sub {
#   print $_[0]->name, "\t";
#   print $_[0]->text, "\n";
# });
print "Tokenization of DATA:\n";

TOKEN:while (not $lexer->eoi) {
    $token = $lexer->next;
    print "Line $.\t";
    print "Type: ", $token->name, "\t";
    print "Content:-> ", $token->text, " <-\n";
}

__END__
1+2-5   # expression
"a multiline
string with an embedded "" in it"
an invalid string with a "" in it"