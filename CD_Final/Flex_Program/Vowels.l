%option noyywrap
%{
#include <stdio.h>
int vowel_count = 0;
%}

%%

[aAeEiIoOuU]    { vowel_count++; }
.|\n            { /* Ignore all other characters */ }

%%

int main() {
    FILE *fp = fopen("vowels.txt", "r");
    if (!fp) {
        perror("Error opening input.txt");
        return 1;
    }

    yyin = fp;
    yylex();
    fclose(fp);

    printf("Total vowels: %d\n", vowel_count);
    return 0;
}
