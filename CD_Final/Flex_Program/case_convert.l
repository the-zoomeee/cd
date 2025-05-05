%option noyywrap
%{
#include <stdio.h>
%}

%%

[a-z]      { printf("%c", yytext[0] - 32); }   /* Convert to uppercase */
.|\n       { printf("%s", yytext); }          /* Print other characters as-is */

%%

int main() {
    FILE *fp = fopen("case_convert.txt", "r");
    if (!fp) {
        perror("Error opening input.txt");
        return 1;
    }

    yyin = fp;
    yylex();
    fclose(fp);
    return 0;
}
