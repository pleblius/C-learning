#include <stdio.h>
#include <stdlib.h>

#include "vector.h"

#define VECTOR_SIZE (vector->size)
#define VECTOR_CAPACITY (vector->capacity)
#define VECTOR_IS_EMPTY (!VECTOR_SIZE)
#define VECTOR_ARRAY (vector->array)
#define LAST_INDEX (VECTOR_SIZE-1)

// Creates an empty vector with the given initial capacity.
Vector* vector_create_cap(int capacity) {
    if (capacity <= 0) {
        fprintf(stderr, "Vector capacity must be greater than 0.\n");
        exit(EXIT_FAILURE);
    }

    Vector *vector = (Vector*) malloc(sizeof(Vector));
    if (!vector) {
        fprintf(stderr, "Vector memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    VECTOR_SIZE = 0;
    VECTOR_CAPACITY = capacity;

    VECTOR_ARRAY = (void**) malloc(sizeof(void*) * capacity);
    if (!VECTOR_ARRAY) {
        fprintf(stderr, "Array memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    return vector;
}

// Creates a vector with the default capacity (10).
Vector* vector_create() {
    return vector_create_cap(10);
}

// Expands the vector's capacity by a factor of 2.
void vector_expand(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    void **temp_array = VECTOR_ARRAY;

    VECTOR_ARRAY = (void**) malloc(sizeof(void*) * 2 * VECTOR_CAPACITY);
    if (!VECTOR_ARRAY) {
        fprintf(stderr, "Array memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }
    
    VECTOR_CAPACITY *= 2;

    int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        VECTOR_ARRAY[i] = temp_array[i];
    }

    free(temp_array);
}

// Shrinks the vector's capacity by a factor of 2.
void vector_shrink(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    void **temp_array = VECTOR_ARRAY;

    VECTOR_ARRAY = (void**) malloc(sizeof(void*) * VECTOR_CAPACITY / 2);
    if (!VECTOR_ARRAY) {
        fprintf(stderr, "Array memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    VECTOR_CAPACITY /= 2;

    int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        VECTOR_ARRAY[i] = temp_array[i];
    }

    free(temp_array);
}

// Inserts the given element into the vector at the given index. All elements at or greater than that index are shifted up 1 index.
void vector_insert(Vector *vector, int index, void *data) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if (index < 0) {
        fprintf(stderr, "Index must be non-negative.\n");
        exit(EXIT_FAILURE);
    }
    if (index > VECTOR_SIZE) {
        fprintf(stderr, "Index exceeds vector length.\n");
        exit(EXIT_FAILURE);
    }

    if (VECTOR_SIZE == VECTOR_CAPACITY) vector_expand(vector);

    int i;
    for (i = LAST_INDEX; i >= index; --i) {
        VECTOR_ARRAY[i+1] = VECTOR_ARRAY[i];
    }

    VECTOR_ARRAY[index] = data;
    ++VECTOR_SIZE;
}

// Adds an element to the end of the vector.
void vector_append(Vector *vector, void *data) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    if (VECTOR_SIZE == VECTOR_CAPACITY) vector_expand(vector);

    VECTOR_ARRAY[VECTOR_SIZE++] = data;
}

// Sets the element stored at the given index to the given value and returns that value if successful, overriding the element at that index. Returns overridden element if successful.
void* vector_set(Vector *vector, int index, void *data) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if (index < 0) {
        fprintf(stderr, "Index must be non-negative.\n");
        exit(EXIT_FAILURE);
    }
    if (index > VECTOR_SIZE) {
        fprintf(stderr, "Index exceeds vector length.\n");
        exit(EXIT_FAILURE);
    }

    void *temp_data = VECTOR_ARRAY[index];
    VECTOR_ARRAY[index] = data;

    return temp_data;
}

// Returns the element stored at the given index.
void* vector_get(Vector *vector, int index) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if (index < 0) {
        fprintf(stderr, "Index must be non-negative.\n");
        exit(EXIT_FAILURE);
    }
    if (index > VECTOR_SIZE) {
        fprintf(stderr, "Index exceeds vector length.\n");
        exit(EXIT_FAILURE);
    }

    return VECTOR_ARRAY[index];
}

// Returns the last element in the vector and removes it from the vector. Returns NULL if unsuccessful.
void* vector_pop_last(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if VECTOR_IS_EMPTY return NULL;

    void* result = vector_get(vector, LAST_INDEX);
    --VECTOR_SIZE;

    if (VECTOR_SIZE < VECTOR_CAPACITY/3 && VECTOR_CAPACITY >= 20)
        vector_shrink(vector);

    return result;
}

// Returns the last element in the vector.
void* vector_peek_last(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if VECTOR_IS_EMPTY return NULL;

    return vector_get(vector, LAST_INDEX);
}

// Returns the number of elements in the vector.
int vector_size(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    return VECTOR_SIZE;
}

// Returns true if the vector is empty.
int vector_is_empty(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    return vector->size == 0;
}

// Clears and frees all elements from the vector. The vector's capacity remains unchanged.
void vector_clear(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }
    if VECTOR_IS_EMPTY return;

    int i;
    for (i = 0; i < VECTOR_SIZE; ++i) {
        free(VECTOR_ARRAY[i]);
        VECTOR_ARRAY[i] = NULL;
    }

    VECTOR_SIZE = 0;
}

// Prints the vector's elements, size, and capacity.
void vector_print(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    int i;
    printf("Array: ");
    for (i = 0; i <= LAST_INDEX; ++i) {
        printf("%p ", VECTOR_ARRAY[i]);
    }

    printf("\nSize: %d \n", VECTOR_SIZE);
    printf("Capacity: %d \n", VECTOR_CAPACITY);
}

// Destroys the given vector.
void vector_destroy(Vector *vector) {
    if (!vector) {
        fprintf(stderr, "Invalid vector reference.\n");
        exit(EXIT_FAILURE);
    }

    vector_clear(vector);
    free(vector -> array);
    free(vector);
}