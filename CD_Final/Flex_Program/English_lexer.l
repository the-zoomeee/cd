%{
#include <stdio.h>
#include <stdlib.h>

int line_no = 1;
%}

%%

\n              { line_no++; }  

a|an|the        { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "ARTICLE", "None"); }

(I|you|he|she|it|we|they) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "PRONOUN", "None"); }

(boy|girl|dog|cat|man|woman|apple|book) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "NOUN", "None"); }

(is|are|was|were|run|walk|swim|eat|write|read|swimming) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "VERB", "None"); }

(happy|sad|big|small|beautiful|ugly) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "ADJECTIVE", "None"); }

(quickly|slowly|happily|sadly) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "ADVERB", "None"); }

(in|on|at|by|with|about|against|between|through) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "PREPOSITION", "None"); }

(and|or|but|so|yet) { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "CONJUNCTION", "None"); }

[0-9]+          { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "CONSTANT", "None"); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("| %-9d | %-9s | %-9s | %-12s |\n", line_no, yytext, "IDENTIFIER", "None"); }

%%

int main() 
{
        FILE *file = fopen("english_lexer.txt", "r");
    if (!file) {
        printf("Error opening file: english_lexer.txt\n");
        return 1;
    }

    // Print the table header
    printf("+----------+-----------+-----------+--------------+\n");
    printf("| Line no  | Lexeme    | Token     | Token-Value  |\n");
    printf("+----------+-----------+-----------+--------------+\n");

    yyin = file;
    yylex();  // Start lexical analysis

    fclose(file);
    return 0;
}

int yywrap() 
{
    return 1; 
}
