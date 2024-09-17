#ifndef vector_h
#define vector_h

#include <stdio.h>
#include <stdlib.h>
#define VECTOR_SIZE (vector->size)
#define VECTOR_CAPACITY (vector->capacity)
#define VECTOR_IS_EMPTY (!VECTOR_SIZE)
#define VECTOR_ARRAY (vector->array)
#define LAST_INDEX (VECTOR_SIZE-1)

typedef struct {
    int *array;
    int size;
    int capacity;
} Vector;

Vector* vector_create_cap(int capacity) {
    if (capacity <= 0) return NULL;

    Vector *vector = (Vector*) malloc(sizeof(Vector));
    if (!vector) return NULL;

    VECTOR_SIZE = 0;
    VECTOR_CAPACITY = capacity;
    VECTOR_ARRAY = (int*) malloc(sizeof(int) * capacity);
    if (!VECTOR_ARRAY) {
        free(vector);
        return NULL;
    }

    return vector;
}

Vector* vector_create() {
    return vector_create_cap(10);
}

void vector_expand(Vector *vector) {
    if (!vector) return;

    int *temp_array = VECTOR_ARRAY;
    VECTOR_CAPACITY *= 2;

    VECTOR_ARRAY = (int*) malloc(sizeof(int) * VECTOR_CAPACITY);
    if (!VECTOR_ARRAY) {
        free(vector);
        free(temp_array);
        return;
    }

     int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        VECTOR_ARRAY[i] = temp_array[i];
    }

    free(temp_array);
}

void vector_shrink(Vector *vector) {
    if (!vector) return;

    int *temp_array = VECTOR_ARRAY;
    VECTOR_CAPACITY /= 2;

    VECTOR_ARRAY = (int*) malloc(sizeof(int) * VECTOR_CAPACITY);
    if (!VECTOR_ARRAY) {
        free(vector);
        free(temp_array);
        return;
    }

    int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        VECTOR_ARRAY[i] = temp_array[i];
    }

    free(temp_array);
}

int vector_insert(Vector *vector, int index, int data) {
    if (!vector || index < 0 || index > VECTOR_SIZE) return 0;

    if (VECTOR_SIZE == VECTOR_CAPACITY) vector_expand(vector);

    int i;
    for (i = LAST_INDEX; i >= index; --i) {
        VECTOR_ARRAY[i+1] = VECTOR_ARRAY[i];
    }

    VECTOR_ARRAY[index] = data;
    ++VECTOR_SIZE;

    return data;
}

int vector_append(Vector *vector, int data) {
    if (!vector) return 0;

    if (VECTOR_SIZE == VECTOR_CAPACITY) vector_expand(vector);

    VECTOR_ARRAY[VECTOR_SIZE++] = data;

    return data;
}

int vector_set(Vector *vector, int index, int data) {
    if (!vector || index < 0 || index >= VECTOR_SIZE) return 0;

    VECTOR_ARRAY[index] = data;
    return data;
}

int vector_get(Vector *vector, int index) {
    if (!vector || index < 0 || index > VECTOR_SIZE) return 0;

    return VECTOR_ARRAY[index];
}

int vector_pop_last(Vector *vector) {
    if (!vector || VECTOR_IS_EMPTY) return 0;

    int result = vector_get(vector, LAST_INDEX);
    --VECTOR_SIZE;

    if (VECTOR_SIZE < VECTOR_CAPACITY/3 && VECTOR_CAPACITY >= 20)
        vector_shrink(vector);

    return result;
}

int vector_peek_last(Vector *vector) {
    if (!vector || VECTOR_IS_EMPTY) return 0;

    return vector_get(vector, LAST_INDEX);
}

int vector_size(Vector *vector) {
    if (!vector) return 0;

    return VECTOR_SIZE;
}

void vector_clear(Vector *vector) {
    if (!vector || VECTOR_IS_EMPTY) return;

    int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        VECTOR_ARRAY[i] = 0;
    }

    VECTOR_SIZE = 0;
}

void vector_print(Vector *vector) {
    if (!vector) return;

    int i;
    printf("Array: ");
    for (i = 0; i <= LAST_INDEX; ++i) {
        printf("%d ", VECTOR_ARRAY[i]);
    }

    printf("\nSize: %d \n", VECTOR_SIZE);
    printf("Capacity: %d \n", VECTOR_CAPACITY);
}

void vector_destroy(Vector *vector) {
    if (!vector) return;

    free(vector -> array);
    free(vector);
}

#endif //vector_h
