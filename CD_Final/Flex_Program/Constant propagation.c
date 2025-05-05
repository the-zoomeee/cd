#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 100

typedef struct {
    char lhs[20];
    char rhs1[20];
    char op[5];
    char rhs2[20];
} Statement;

typedef struct {
    char var[20];
    char value[20];
} Constant;

int isConstant(char *s) {
    for (int i = 0; s[i]; i++) {
        if (s[i] < '0' || s[i] > '9') return 0;
    }
    return 1;
}

void propagateConstants(Statement stmts[], int n) {
    Constant table[MAX];
    int constCount = 0;

    // First pass: propagate known constants
    for (int i = 0; i < n; i++) {
        // Replace known constants in rhs1 and rhs2
        for (int j = 0; j < constCount; j++) {
            if (strcmp(stmts[i].rhs1, table[j].var) == 0) {
                strcpy(stmts[i].rhs1, table[j].value);
            }
            if (strcmp(stmts[i].rhs2, table[j].var) == 0) {
                strcpy(stmts[i].rhs2, table[j].value);
            }
        }

        // If it's an assignment and rhs1 is constant
        if (strcmp(stmts[i].op, "") == 0 && isConstant(stmts[i].rhs1)) {
            strcpy(table[constCount].var, stmts[i].lhs);
            strcpy(table[constCount].value, stmts[i].rhs1);
            constCount++;
        }

        // If it's a binary operation, check if both operands are constants
        if (strcmp(stmts[i].op, "+") == 0 || strcmp(stmts[i].op, "-") == 0 ||
            strcmp(stmts[i].op, "*") == 0 || strcmp(stmts[i].op, "/") == 0) {

            if (isConstant(stmts[i].rhs1) && isConstant(stmts[i].rhs2)) {
                int val1 = atoi(stmts[i].rhs1);
                int val2 = atoi(stmts[i].rhs2);
                int result = 0;

                if (strcmp(stmts[i].op, "+") == 0)
                    result = val1 + val2;
                else if (strcmp(stmts[i].op, "-") == 0)
                    result = val1 - val2;
                else if (strcmp(stmts[i].op, "*") == 0)
                    result = val1 * val2;
                else if (strcmp(stmts[i].op, "/") == 0)
                    result = val1 / val2;

                // Store result as a constant value
                sprintf(stmts[i].rhs1, "%d", result);
                stmts[i].op[0] = '\0';  // Remove the operator since it's now a constant
                stmts[i].rhs2[0] = '\0'; // Remove rhs2 as it's no longer needed
            }
        }
    }
}

void printStatements(Statement stmts[], int n) {
    printf("\nAfter Constant Propagation:\n");
    for (int i = 0; i < n; i++) {
        if (strcmp(stmts[i].op, "") == 0)
            printf("%s = %s\n", stmts[i].lhs, stmts[i].rhs1);
        else
            printf("%s = %s %s %s\n", stmts[i].lhs, stmts[i].rhs1, stmts[i].op, stmts[i].rhs2);
    }
}

int main() {
    Statement stmts[MAX];
    int n;

    printf("Enter number of statements: ");
    scanf("%d", &n);

    printf("Enter statements in format (lhs rhs1 op rhs2), leave op and rhs2 blank for simple assignment:\n");

    for (int i = 0; i < n; i++) {
        scanf("%s %s %s %s", stmts[i].lhs, stmts[i].rhs1, stmts[i].op, stmts[i].rhs2);
    }

    propagateConstants(stmts, n);
    printStatements(stmts, n);

    return 0;
}

/* 5
a 5  
b a  
c a + b
d 3 + 7
e d * 2
*/