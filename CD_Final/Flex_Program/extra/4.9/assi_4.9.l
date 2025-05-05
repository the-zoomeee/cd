%{
#include <stdio.h>
int round_c = 0, curly = 0, square = 0;
%}

%%
\(     { round_c++; }
\)     { round_c--; }
\{     { curly++; }
\}     { curly--; }
\[     { square++; }
\]     { square--; }
.|\n   ;  // Ignore other characters
%%

int yywrap() { return 1; }

int main() {
    printf("Enter expression with parentheses: ");
    yylex();
    if (round_c == 0 && curly == 0 && square == 0)
        printf("Balanced Parentheses\n");
    else
        printf("Unbalanced Parentheses\n");
    return 0;
}
