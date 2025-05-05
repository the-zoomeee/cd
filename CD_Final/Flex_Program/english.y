%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex();

int yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}
%}

%token NOUN VERB ADJ ARTICLE

%%

sentence:
    noun_phrase VERB noun_phrase '.'   { printf(" Valid sentence.\n"); }
    ;

noun_phrase:
    ARTICLE ADJ NOUN
    | ARTICLE NOUN
    | ADJ NOUN
    | NOUN
    ;

%%

int main() {
    yyin = fopen("english_input.txt", "r");
    if (!yyin) {
        perror("fopen");
        return 1;
    }
    yyparse();
    return 0;
}
