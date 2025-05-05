#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

typedef struct {
    char op[5];
    char arg1[20];
    char arg2[20];
    char result[20];
    int folded;  // flag to show if folding was done
} Quadruple;

// Utility to check if a string is a number
int isConstant(char *s) {
    for (int i = 0; s[i]; i++) {
        if (!isdigit(s[i])) return 0;
    }
    return 1;
}

// Perform constant folding on the list of quadruples
void constantFolding(Quadruple quads[], int n) {
    for (int i = 0; i < n; i++) {
        if (isConstant(quads[i].arg1) && isConstant(quads[i].arg2)) {
            int a = atoi(quads[i].arg1);
            int b = atoi(quads[i].arg2);
            int res;

            if (strcmp(quads[i].op, "+") == 0)
                res = a + b;
            else if (strcmp(quads[i].op, "-") == 0)
                res = a - b;
            else if (strcmp(quads[i].op, "*") == 0)
                res = a * b;
            else if (strcmp(quads[i].op, "/") == 0 && b != 0)
                res = a / b;
            else
                continue;

            sprintf(quads[i].arg1, "%d", res);
            strcpy(quads[i].arg2, "");
            strcpy(quads[i].op, "=");
            quads[i].folded = 1;

            printf("Folded constant expression in %s: result = %d\n", quads[i].result, res);
        }
    }
}

// Print the final optimized quadruples
void printQuads(Quadruple quads[], int n) {
    printf("\nOptimized Quadruples:\n");
    for (int i = 0; i < n; i++) {
        printf("(%s, %s, %s, %s)\n",
               quads[i].op,
               quads[i].arg1,
               strlen(quads[i].arg2) ? quads[i].arg2 : "-",
               quads[i].result);
    }
}

int main() {
    int n;
    Quadruple quads[MAX];

    printf("Enter number of quadruples: ");
    scanf("%d", &n);

    printf("Enter quadruples (op arg1 arg2 result):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s %s %s %s", quads[i].op, quads[i].arg1, quads[i].arg2, quads[i].result);
        quads[i].folded = 0;
    }

    constantFolding(quads, n);
    printQuads(quads, n);

    return 0;
}

/*3
+ 2 3 t1
* 4 5 t2
+ t1 t2 t3
*/