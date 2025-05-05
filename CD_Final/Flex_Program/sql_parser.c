#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LEN 100

const char *keywords[] = {"SELECT", "FROM", "WHERE", "INSERT", "INTO", "VALUES", "UPDATE", "SET", "DELETE"};
const int keyword_count = sizeof(keywords) / sizeof(keywords[0]);

int isKeyword(char *word) {
    for (int i = 0; i < keyword_count; i++) {
        if (strcasecmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}

int isOperator(char ch) {
    return (ch == '=' || ch == '<' || ch == '>' || ch == '!');
}

void lexicalAnalyzer(FILE *file) {
    char token[MAX_LEN];
    int index = 0, line_no = 1;
    char ch;

    printf("+----------+-----------+-----------+--------------+\n");
    printf("| Line no  | Lexeme    | Token     | Token-Value  |\n");
    printf("+----------+-----------+-----------+--------------+\n");

    while ((ch = fgetc(file)) != EOF) {
        if (ch == '\n') {
            line_no++;
            continue;
        }

        if (isspace(ch)) {
            continue;
        }

        if (isalpha(ch)) { // Identifier or Keyword
            index = 0;
            while (isalnum(ch) || ch == '_') {
                token[index++] = ch;
                ch = fgetc(file);
            }
            token[index] = '\0';
            ungetc(ch, file);
            if (isKeyword(token)) {
                printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, token, "Keyword", "");
            } else {
                printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, token, "Identifier", "");
            }
        }
        else if (isdigit(ch)) { // Number
            index = 0;
            while (isdigit(ch)) {
                token[index++] = ch;
                ch = fgetc(file);
            }
            token[index] = '\0';
            ungetc(ch, file);
            printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, token, "Number", token);
        }
        else if (isOperator(ch)) { // Operators
            char op[3] = {ch, '\0', '\0'};
            char next = fgetc(file);
            if ((ch == '!' || ch == '<' || ch == '>') && next == '=') {
                op[1] = '=';
            } else {
                ungetc(next, file);
            }
            printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, op, "Operator", "");
        }
        else if (ch == ',' || ch == ';' || ch == '(' || ch == ')') { // Punctuation
            char sym[2] = {ch, '\0'};
            printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, sym, "Symbol", "");
        }
        else { // Unknown
            char unk[2] = {ch, '\0'};
            printf("| %-8d | %-9s | %-9s | %-12s |\n", line_no, unk, "Unknown", "");
        }
    }

    printf("+----------+-----------+-----------+--------------+\n");
}

int main() {
    FILE *file = fopen("sql.txt", "r");
    if (!file) {
        printf("Error: Could not open input file.\n");
        return 1;
    }
    lexicalAnalyzer(file);
    fclose(file);
    return 0;
}
