%{
#include <stdio.h>
%}

%%
[ \t\n]+  { /* Ignore spaces, tabs, and new lines */ }
"//".*    { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+"/" { /* Ignore multi-line comments */ }

%%

int yywrap() { return 1; }
int main() {
    printf("Enter code: ");
    yylex();
    return 0;
}
