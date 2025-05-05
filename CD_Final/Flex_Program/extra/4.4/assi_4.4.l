%{
#include <stdio.h>
#include <string.h>
%}

%%

[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}  { printf("Valid Email: %s\n", yytext); }
[^\n]+                                            { printf("Invalid Email: %s\n", yytext); }
\n                                                ; // Ignore newlines

%%

int yywrap() { return 1; }

int main() {
    printf("Enter an email: ");
    yylex();
    return 0;
}
