%{
#include <stdio.h>
%}

%%

(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)[0-9]{2} { printf("Valid Date Format: %s\n", yytext); }
[^\n]+                                                           { printf("Invalid Date Format: %s\n", yytext); }
\n                                                               ; // Ignore newline

%%

int yywrap() { return 1; }

int main() {
    printf("Enter date: ");
    yylex();
    return 0;
}
