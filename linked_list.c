#include "linked_list.h"
#include <stdio.h>

void print_prompt();

int main() {
    int exit = 0;
    int entry = 0;
    LinkedList *list = list_create();

    while (!exit) {
        print_prompt();

        scanf("%d", &entry);

        switch (entry) {
            case 0:
                list_destroy(list);
                exit = 1;
                break;
            case 1:
                list_print(list);
                break;
            case 2:
                printf("Value: \n");
                scanf("%d", &entry);
                list_add_first(list, entry);
                break;
            case 3:
                printf("Value: \n");
                scanf("%d", &entry);
                list_add_last(list, entry);
                break;
            case 4:
                printf("First: %d \n", list_peek_first(list));
                break;
            case 5:
                printf("Last: %d \n", list_peek_last(list));
                break;
            case 6:
                printf("Pop first: %d \n", list_pop(list));
                break;
            case 7:
                printf("Size: %d \n", list_size(list));
                break;
            case 8:
                printf("List cleared\n");
                list_clear(list);
                break;
        }
    }
    
    return 0;
}

void print_prompt() {
    printf("Please choose one of the following options:\n");
    printf("0: Exit program\n");
    printf("1: Print the existing list\n");
    printf("2: Add a value to the front of the list\n");
    printf("3: Add a value to the back of the list\n");
    printf("4: Print the first value\n");
    printf("5: Print the last value\n");
    printf("6: Print the first value and remove it from the list\n");
    printf("7: Print the list's current size\n");
    printf("8: Clear the list of all elements\n");
}
