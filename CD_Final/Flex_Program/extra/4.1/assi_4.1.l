%{
#include <stdio.h>
%}

%%

[0-9]+            { printf("Integer: %s\n", yytext); }
[0-9]+\.[0-9]+     { printf("Floating Point: %s\n", yytext); }
'.'                { printf("Character: %s\n", yytext); }
[ \t\n]+           { /* Ignore spaces, tabs, and newlines */ }
[^0-9a-zA-Z\s]     { printf("Invalid Character: %s\n", yytext); }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter input: ");
    yylex();
    return 0;
}
