#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

const char *cpp_keywords[] = {
    "int", "float", "double", "char", "bool", "void", "if", "else", "for", "while", "do", "switch", "case",
    "break", "continue", "return", "class", "public", "private", "protected", "new", "delete", "this", "namespace",
    "using", "include", "template", "try", "catch", "throw", "true", "false", "nullptr", "const", "static"
};
int num_cpp_keywords = sizeof(cpp_keywords) / sizeof(cpp_keywords[0]);

int isKeyword(const char *word) {
    for (int i = 0; i < num_cpp_keywords; ++i) {
        if (strcmp(word, cpp_keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int isOperator(char ch) {
    return strchr("+-*/%=<>!&|^~", ch) != NULL;
}

void tokenizeCPP(const char *input) {
    int i = 0;
    char token[100];
    int idx;

    while (input[i] != '\0') {
        if (isspace(input[i])) {
            i++;
        } else if (isalpha(input[i]) || input[i] == '_') {
            idx = 0;
            while (isalnum(input[i]) || input[i] == '_')
                token[idx++] = input[i++];
            token[idx] = '\0';
            if (isKeyword(token))
                printf("Keyword: %s\n", token);
            else
                printf("Identifier: %s\n", token);
        } else if (isdigit(input[i])) {
            idx = 0;
            while (isdigit(input[i]))
                token[idx++] = input[i++];
            token[idx] = '\0';
            printf("Number: %s\n", token);
        } else if (input[i] == '"') {
            idx = 0;
            token[idx++] = input[i++];
            while (input[i] != '"' && input[i] != '\0')
                token[idx++] = input[i++];
            token[idx++] = input[i++];
            token[idx] = '\0';
            printf("String Literal: %s\n", token);
        } else if (input[i] == '/' && input[i + 1] == '/') {
            printf("Single-line Comment: //...\n");
            break;
        } else if (isOperator(input[i])) {
            printf("Operator: %c\n", input[i++]);
        } else if (strchr("();{},.[]", input[i])) {
            printf("Punctuation: %c\n", input[i++]);
        } else {
            printf("Unknown: %c\n", input[i++]);
        }
    }
}

int main() {
    char code[512];
    printf("Enter C++ code line: ");
    fgets(code, sizeof(code), stdin);
    tokenizeCPP(code);
    return 0;
}

//#include <iostream> using namespace std; int main() { cout << "Hello"; }
