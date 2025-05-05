%option noyywrap case-insensitive

%{
#include "english.tab.h"
#include <string.h>
%}

%%

"John"|"Mary"|"dog"|"cat"|"apples"|"ball"|"bananas"    { return NOUN; }
"eats"|"likes"|"hates"|"chases"                        { return VERB; }
"big"|"small"|"red"|"blue"|"green"                     { return ADJ; }
"a"|"the"                                               { return ARTICLE; }

[ \t\n]+        ;   // skip whitespace
"."             { return '.'; }

.               { printf(" Unknown word: %s\n", yytext); }

%%

