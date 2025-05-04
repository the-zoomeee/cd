%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define MODE_JAVA 3

int line_num = 1;
int column_num = 1;

const char *javaKeywords[] = {
    "abstract", "assert", "boolean", "break", "byte", "case", "catch",
    "char", "class", "const", "continue", "default", "do", "double",
    "else", "enum", "extends", "final", "finally", "float", "for",
    "goto", "if", "implements", "import", "instanceof", "int",
    "interface", "long", "native", "new", "package", "private",
    "protected", "public", "return", "short", "static", "strictfp",
    "super", "switch", "synchronized", "this", "throw", "throws",
    "transient", "try", "void", "volatile", "while", NULL
};

int isInList(const char *word, const char **list) {
    for (int i = 0; list[i] != NULL; i++) {
        if (strcasecmp(word, list[i]) == 0) return 1;
    }
    return 0;
}

const char* getTokenType(const char *value) {
    if (isInList(value, javaKeywords)) return "KEYWORD";
    if (isdigit(value[0])) return "NUMBER";
    if (value[0] == '\'' || value[0] == '"') return "STRING";
    if (strcmp(value, ";") == 0 || strcmp(value, ",") == 0 ||
        strcmp(value, "(") == 0 || strcmp(value, ")") == 0 ||
        strcmp(value, "{") == 0 || strcmp(value, "}") == 0 ||
        strcmp(value, "[") == 0 || strcmp(value, "]") == 0 ||
        strcmp(value, ".") == 0) return "SYMBOL";
    if (strcmp(value, "=") == 0 || strcmp(value, "+") == 0 ||
        strcmp(value, "-") == 0 || strcmp(value, "*") == 0 ||
        strcmp(value, "/") == 0 || strcmp(value, "%") == 0 ||
        strcmp(value, "==") == 0 || strcmp(value, "!=") == 0 ||
        strcmp(value, ">") == 0 || strcmp(value, "<") == 0 ||
        strcmp(value, ">=") == 0 || strcmp(value, "<=") == 0 ||
        strcmp(value, "++") == 0 || strcmp(value, "--") == 0 ||
        strcmp(value, "+=") == 0 || strcmp(value, "-=") == 0 ||
        strcmp(value, "*=") == 0 || strcmp(value, "/=") == 0) return "OPERATOR";
    if (isalpha(value[0]) || value[0] == '_') return "IDENTIFIER";
    return "UNKNOWN";
}
%}

%option noyywrap

DIGIT       [0-9]
LETTER      [a-zA-Z]
ID          ({LETTER}|_)({LETTER}|{DIGIT}|_)*
NUMBER      {DIGIT}+(\.{DIGIT}+)?
STRING      \"([^\"]*)\"|\'([^\']*)\'
OPERATOR    "=="|"!="|">="|"<="|">"|"<"|"="|"+"|"-"|"*"|"/"|"%"|"++"|"--"|"+="|"-="|"*="|"/="
SYMBOL      [;,.(){}\[\]]
WHITESPACE  [ \t]+
NEWLINE     \n
%%

{WHITESPACE} { column_num += yyleng; }

{NEWLINE}    { line_num++; column_num = 1; }

{STRING}     {
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, "STRING", yytext);
    column_num += yyleng;
}

{OPERATOR}   {
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, "OPERATOR", yytext);
    column_num += yyleng;
}

{SYMBOL}     {
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, "SYMBOL", yytext);
    column_num += yyleng;
}

{NUMBER}     {
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, "NUMBER", yytext);
    column_num += yyleng;
}

{ID}         {
    const char *type = getTokenType(yytext);
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, type, yytext);
    column_num += yyleng;
}

.            {
    printf("| %-6d | %-6d | %-15s | %-10s | %-12s |\n",
           column_num, line_num, yytext, "ERROR", yytext);
    column_num += yyleng;
}

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    printf("| %-6s | %-6s | %-15s | %-10s | %-12s |\n",
           "Column", "Line", "Lexeme", "Token", "Token Value");
    printf("|--------|--------|-----------------|------------|--------------|\n");

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Error opening file: %s\n", argv[1]);
        return 1;
    }

    yylex();
    fclose(yyin);
    return 0;
}
