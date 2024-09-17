#ifndef linked_list_h
#define linked_list_h
#include <stdlib.h>
#include <stdio.h>

struct Node {
    struct Node *next;
    int data;
};

typedef struct Node Node;

typedef struct {
    Node *head;
    Node *tail;
    unsigned int size;    
} LinkedList;

LinkedList* list_create() {
    LinkedList *list = (LinkedList*) malloc(sizeof(LinkedList));
    if (!list) return NULL;
    list -> head = NULL;
    list -> tail = NULL;
    list -> size = 0;

    return list;
}

int list_pop(LinkedList *list) {
    if (!list || !(list -> size)) return 0;

    Node *head = list -> head;
    int data = head -> data;

    list -> head = head -> next;
    free(head);

    if (!--(list -> size)) list -> tail = NULL;

    return data;
}

int list_peek_first(LinkedList *list) {
    if (!list || !(list -> size)) return 0;

    return list -> head -> data;
}

int list_peek_last(LinkedList *list) {
    if (!list || !(list -> size)) return 0;

    return list -> tail -> data;
}

int list_size(LinkedList *list) {
    if (!list) return 0;

    return list -> size;
}

int list_add_first(LinkedList *list, int data) {
    if (!list) return 0;

    Node *node = (Node*) malloc(sizeof(Node));
    if (!node) return 0;

    node -> data = data;
    node -> next = list -> head;
    list -> head = node;

    if (!(list -> size)) list -> tail = node;

    ++(list -> size);
    return 1;
}

int list_add_last(LinkedList *list, int data) {
    if (!list) return 0;

    if (!(list -> size)) return list_add_first(list, data);

    Node *node = (Node*) malloc(sizeof(Node));
    if (!node) return 0;

    node -> next = NULL;
    list -> tail -> next = node;
    list -> tail = node;
    node -> data = data;

    ++(list -> size);

    return 1;
}

void list_clear(LinkedList *list) {
    if (!list || !(list -> size)) return;

    Node *node = list -> head;
    Node *nextNode;

    while (node) {
        nextNode = node -> next;
        free(node);
        node = nextNode;
    }

    list -> head = list -> tail = NULL;
    list -> size = 0;
}

void list_print(LinkedList *list) {
    if (!list) return;

    Node *node = list -> head;
    unsigned int count = 0;

    while (node) {
        printf("Node %d: %d \n", count++, node -> data);
        node = node -> next;
    }

    printf("Size: %d \n", list -> size);
}

void list_destroy(LinkedList *list) {
    if (!list) return;
    list_clear(list);
    free(list);
}

#endif //linked_list_h
