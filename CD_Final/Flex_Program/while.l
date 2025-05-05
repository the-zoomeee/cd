%{
#include "while.tab.h"
#include <stdio.h>
int yylineno = 1;
%}

%%

\n           { yylineno++; }
"while"      { return WHILE; }
"do"         { return DO; }
"{"          { return LBRACE; }
"}"          { return RBRACE; }
"("          { return LPAREN; }
")"          { return RPAREN; }
";"          { return SEMICOLON; }
"="          { return ASSIGN; }
"=="|"!="|"<="|">="|"<"|">"  { return RELOP; }
"+"|"-"|"*"|"/"              { return OP; }
[a-zA-Z_][a-zA-Z0-9_]*       { return ID; }
[0-9]+        { return NUM; }
[ \t\r]+      { /* ignore whitespace */ }
.             { printf("Error: Line %d - Invalid token: %s\n", yylineno, yytext); return -1; }

%%

int yywrap() { return 1; }
