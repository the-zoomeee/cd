%option noyywrap
%{
#include <stdio.h>
int consonant_count = 0;
%}

%%

[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]   { consonant_count++; }
.|\n                               { /* Ignore all other characters */ }

%%

int main() {
    FILE *fp = fopen("consonant.txt", "r");
    if (!fp) {
        perror("Error opening input.txt");
        return 1;
    }

    yyin = fp;
    yylex();
    fclose(fp);

    printf("Total consonants: %d\n", consonant_count);
    return 0;
}
