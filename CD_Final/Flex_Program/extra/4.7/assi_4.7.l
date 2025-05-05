%{
#include <stdio.h>
#include <string.h>

char word_to_count[100];
int count = 0;
%}

%%
[a-zA-Z0-9_]+ {
    if (strcmp(yytext, word_to_count) == 0)
        count++;
}
[ \t\n]+   ;  // Ignore whitespace
.          ;  // Ignore all other characters
%%

int yywrap() { return 1; }

int main() {
    char input[1024];
    
    printf("Enter the word to count: ");
    scanf("%s", word_to_count);
    getchar();  // Consume leftover newline from scanf

    printf("Enter the text: ");
    fgets(input, sizeof(input), stdin);

    YY_BUFFER_STATE buffer = yy_scan_string(input);
    yylex();
    yy_delete_buffer(buffer);

    printf("Frequency of '%s': %d\n", word_to_count, count);
    return 0;
}
