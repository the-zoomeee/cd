%{
#include "c.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

"main"          { return MAIN; }
"int"           { return INT; }
[0-9]+          { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

"="             { return '='; }
";"             { return ';'; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
[+\-*/]         { return yytext[0]; }

[ \t\n]+        ;   // Skip whitespace
.               { printf("Unknown: %s\n", yytext); }

%%

int yywrap() { return 1; }
