%{
#include <stdio.h>
int sentences = 0;
%}

%%
[.!?] { sentences++; }

%%

int yywrap() { return 1; }
int main() {
    printf("Enter text: ");
    yylex();
    printf("Number of Sentences: %d\n", sentences);
    return 0;
}
