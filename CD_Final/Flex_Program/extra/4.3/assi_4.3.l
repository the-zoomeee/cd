%{
#include <stdio.h>
%}

%%
[+\-*/=] { printf("Operator: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Operand: %s\n", yytext); }

%%

int yywrap() { return 1; }
int main() {
    printf("Enter expression: ");
    yylex();
    return 0;
}
