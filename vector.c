#include "vector.h"
#include <stdio.h>

void print_prompt();

int main() {
    int exit = 0;
    int entry = 0;
    int entry2 = 0;
    Vector *list = vector_create();

    while (!exit) {
        print_prompt();

        scanf("%d", &entry);

        switch (entry) {
            case 0:
                vector_destroy(list);
                exit = 1;
                break;
            case 1:
                vector_print(list);
                break;
            case 2:
                printf("Value: ");
                scanf("%d", &entry);
                vector_append(list, entry);
                break;
            case 3:
                printf("Value: ");
                scanf("%d", &entry);
                printf("Index: ");
                scanf("%d", &entry2);
                vector_insert(list, entry2, entry);
                break;
            case 4:
                printf("Value: ");
                scanf("%d", &entry);
                printf("Index: ");
                scanf("%d", &entry2);
                vector_set(list, entry2, entry);
                break;
            case 5:
                printf("Index: ");
                scanf("%d", &entry);
                printf("Index: %d, Value: %d \n", entry, vector_get(list, entry));
                break;
            case 6:
                printf("Pop Last: %d \n", vector_pop_last(list));
                break;
            case 7:
                printf("Size: %d \n", vector_size(list));
                break;
            case 8:
                printf("List cleared\n");
                vector_clear(list);
                break;
        }
    }
    
    return 0;
}

void print_prompt() {
    printf("\n");
    printf("Please choose one of the following options:\n");
    printf("0: Exit program\n");
    printf("1: Print the existing list\n");
    printf("2: Add a value to the end of the array\n");
    printf("3: Add a value at a given index\n");
    printf("4: Set a value at a given index\n");
    printf("5: Print a value at a given index\n");
    printf("6: Print the last value and remove it from the list\n");
    printf("7: Print the list's current size\n");
    printf("8: Clear the list of all elements\n");
}
