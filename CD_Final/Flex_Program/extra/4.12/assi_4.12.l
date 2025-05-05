%{
#include <stdio.h>
%}

%%

"int"|"float"|"char"|"double"|"if"|"else"|"while"|"return" { printf("Keyword: %s\n", yytext);}

[a-zA-Z_][a-zA-Z0-9_]* {    printf("Identifier: %s\n", yytext);}

[0-9]+     ;

[{}();=+*/<>&|!%-]  ;

[ \t\n]+   ;

. ;  
%%

int yywrap() { return 1; }

int main() {
    printf("Enter C code snippet: ");
    yylex();
    return 0;
}
