%{
#include <stdio.h>
int positive=0, negative=0;
%}

%%
[0-9]+ { positive++; }
-[0-9]+ { negative++; }

%%

int yywrap() { return 1; }
int main() {
    printf("Enter numbers: ");
    yylex();
    printf("Positive Integers: %d\nNegative Integers: %d\n", positive, negative);
    return 0;
}
