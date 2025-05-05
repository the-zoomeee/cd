%option noyywrap
%{
#include <stdio.h>
int sentence_count = 0;
%}

%%

[.!?]       { sentence_count++; }
.|\n        { /* Ignore all other characters */ }

%%

int main() {
    FILE *fp = fopen("sentence.txt", "r");
    if (!fp) {
        perror("Error opening input.txt");
        return 1;
    }

    yyin = fp;
    yylex();
    fclose(fp);

    printf("Total sentences: %d\n", sentence_count);
    return 0;
}
