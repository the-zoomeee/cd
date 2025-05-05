%{
#include <stdio.h>
int digits=0, letters=0, specials=0;
%}

%%
[0-9]       { digits++; }
[a-zA-Z]    { letters++; }
[^a-zA-Z0-9 \n\t] { specials++; }
.|\n        ;
%%

int yywrap() { return 1; }
int main() {
    printf("Enter input: ");
    yylex();
    printf("Digits: %d, Letters: %d, Special Characters: %d\n", digits, letters, specials);
    return 0;
}
