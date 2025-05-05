%{
#include <stdio.h>
int vowel_count = 0, word_count = 0, line_count = 0, char_count = 0;
int in_string = 0;  // Flag to track string literals
%}

%%

\" { in_string = !in_string; putchar(yytext[0]); char_count++; }  // Detect string literals

[aeiou] { vowel_count++; putchar(yytext[0] - 32); }  // Convert lowercase vowels to uppercase and count
[a-z] { putchar(yytext[0] - 32); }  // Convert lowercase consonants to uppercase
[A-Z] { putchar(yytext[0]); }  // Print uppercase letters as is
\n { line_count++; char_count++; putchar('\n'); }  // Count lines
[ \t]+ { word_count++; char_count += yyleng; }  // Count words and spaces
. { char_count++; putchar(yytext[0]); }  // Count other characters and print them

%%

int main() {
    FILE *fp;

    // Open predefined input file "all_in_one.txt"
    fp = fopen("all_in_one.txt", "r");
    if (!fp) {
        printf("Error: Could not open file all_in_one.txt\n");
        return 1;
    }

    yyin = fp;

    yylex();

    fclose(fp);

    printf("\nTotal Vowels: %d\n", vowel_count);
    printf("Total Words: %d\n", word_count);
    printf("Total Lines: %d\n", line_count);
    printf("Total Characters: %d\n", char_count);

    return 0;
}

int yywrap() { return 1; }
