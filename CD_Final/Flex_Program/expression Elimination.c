#include <stdio.h>
#include <string.h>
#define MAX 100

typedef struct {
    char op[5];   
 char arg1[20];
   

 char arg2[20];
    char result[20];
    int isEliminated;
} Quadruple;

int isCommutative(char *op) {
    return (strcmp(op, "+") == 0 || strcmp(op, "*") == 0);
}

int isSameExpression(Quadruple *q1, Quadruple *q2) {
    if (strcmp(q1->op, q2->op) != 0)
        return 0;

    if (isCommutative(q1->op)) {
        return (
            (strcmp(q1->arg1, q2->arg1) == 0 && strcmp(q1->arg2, q2->arg2) == 0) ||
            (strcmp(q1->arg1, q2->arg2) == 0 && strcmp(q1->arg2, q2->arg1) == 0)
        );
    } else {
        return (strcmp(q1->arg1, q2->arg1) == 0 && strcmp(q1->arg2, q2->arg2) == 0);
    }
}

void performCSE(Quadruple quads[], int n) {
    for (int i = 0; i < n; i++) {
        if (quads[i].isEliminated) continue;

        for (int j = 0; j < i; j++) {
            if (!quads[j].isEliminated && isSameExpression(&quads[i], &quads[j])) {
                printf("Eliminating common subexpression in %s: replaced with %s\n", quads[i].result, quads[j].result);
                strcpy(quads[i].arg1, quads[j].result);
                strcpy(quads[i].arg2, "");
                strcpy(quads[i].op, "=");
                break;
            }
        }
    }
}

void printQuads(Quadruple quads[], int n) {
    printf("\nOptimized Quadruples:\n");
    for (int i = 0; i < n; i++) {
        if (!quads[i].isEliminated) {
            printf("(%s, %s, %s, %s)\n",
                   quads[i].op,
                   quads[i].arg1,
                   strlen(quads[i].arg2) > 0 ? quads[i].arg2 : "-",
                   quads[i].result);
        }
    }
}

int main() {
    int n;
    Quadruple quads[MAX];

    printf("Enter number of quadruples: ");
    scanf("%d", &n);

    printf("Enter quadruples in format (op arg1 arg2 result):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s %s %s %s", quads[i].op, quads[i].arg1, quads[i].arg2, quads[i].result);
        quads[i].isEliminated = 0;
    }

    performCSE(quads, n);
    printQuads(quads, n);

    return 0;
}
