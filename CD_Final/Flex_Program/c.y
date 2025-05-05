%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
int yylex();
int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}
%}

%union {
    char *str;
    int num;
}

%token MAIN INT
%token <str> ID
%token <num> NUM

%left '+' '-'
%left '*' '/'

%%

program:
    MAIN '(' ')' '{' stmts '}' { printf("Parsed main block\n"); }
    ;

stmts:
    stmts stmt | stmt
    ;

stmt:
    INT ID ';'         { printf("Decl: int %s\n", $2); free($2); }
  | ID '=' expr ';'    { printf("Assign: %s = (expr)\n", $1); free($1); }
    ;

expr:
    expr '+' expr      { printf("Add\n"); }
  | expr '-' expr      { printf("Sub\n"); }
  | expr '*' expr      { printf("Mul\n"); }
  | expr '/' expr      { printf("Div\n"); }
  | '(' expr ')'
  | NUM                { printf("Num: %d\n", $1); }
  | ID                 { printf("Var: %s\n", $1); free($1); }
    ;

%%

int main() {
    yyin = fopen("c_input.txt", "r");
    if (!yyin) {
        perror("fopen");
        return 1;
    }
    yyparse();
    return 0;
}
