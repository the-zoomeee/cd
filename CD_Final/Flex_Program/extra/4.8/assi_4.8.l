%{
#include <stdio.h>
%}

%%
"one"   { printf("1 "); }
"two"   { printf("2 "); }
"three"   { printf("3 "); }
"four"   { printf("4 "); }
"five"   { printf("5 "); }
"six"   { printf("6 "); }
"seven"   { printf("7 "); }
"eight"   { printf("8 "); }
"nine"   { printf("9 "); }
"zero"   { printf("0 "); }
"1"     { printf("one "); }
"2"     { printf("two "); }
"3"     { printf("three "); }
"4"     { printf("four "); }
"5"     { printf("five "); }
"6"     { printf("six "); }
"7"     { printf("seven "); }
"8"     { printf("eight "); }
"9"     { printf("nine "); }
"0"     { printf("zero "); }

.|\n    { ECHO; }
%%

int yywrap() { return 1; }
int main() {
    printf("Enter text: ");
    yylex();
    return 0;
}
