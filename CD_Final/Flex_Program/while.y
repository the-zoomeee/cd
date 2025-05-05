%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
void yyerror(const char *s);
int yylex();
extern FILE *yyin;
int success = 1;
%}

%token WHILE DO LBRACE RBRACE LPAREN RPAREN SEMICOLON ASSIGN RELOP OP ID NUM

%%

program:
    /* empty */
    | program statement
    ;

statement:
    while_stmt
    | do_while_stmt
    | expr_stmt
    | compound_stmt
    ;

while_stmt:
    WHILE LPAREN expression RPAREN compound_stmt
  | WHILE LPAREN error RPAREN compound_stmt {
        yyerror("Invalid condition in WHILE");
        success = 0;
        YYERROR;
    }
    ;

do_while_stmt:
    DO compound_stmt WHILE LPAREN expression RPAREN SEMICOLON
  | DO compound_stmt WHILE LPAREN error RPAREN SEMICOLON {
        yyerror("Invalid condition in DO-WHILE");
        success = 0;
        YYERROR;
    }
    ;

compound_stmt:
    LBRACE statement_list RBRACE
  | LBRACE error RBRACE {
        yyerror("Invalid statement inside compound block");
        success = 0;
        YYERROR;
    }
    ;

statement_list:
    /* empty */
    | statement_list statement
    ;

expr_stmt:
    expression SEMICOLON
  | error SEMICOLON {
        yyerror("Invalid expression");
        success = 0;
        YYERROR;
    }
    ;

expression:
    ID ASSIGN expression
    | logic_expr
    ;

logic_expr:
    rel_expr
    | logic_expr OP rel_expr
    ;

rel_expr:
    ID
    | NUM
    | ID RELOP ID
    | ID RELOP NUM
    | NUM RELOP ID
    | NUM RELOP NUM
    | LPAREN expression RPAREN
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error [Line %d]: %s\n", yylineno, s);
    success = 0;
}

int main() {
    FILE *fp;

    fp = fopen("while.txt", "r"); // Open the default input file "while.txt"
    if (!fp) {
        printf("Error: Could not open file while.txt\n");
        return 1;
    }

    yyin = fp;  // Set the file pointer for the lexer

    yyparse(); // Call the parser

    fclose(fp); // Close the file

    printf("Syntax check completed.\n");
    if (success) {
        printf("Correct Syntax\n");
    } else {
        printf("Syntax Errors Found\n");
    }

    return 0;
}
