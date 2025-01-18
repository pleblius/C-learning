#include <stdio.h>

int decode(long*, long*, int, short);

int main() {
}

int decode (long *p1, long *p2, int a, short b) {
    return a + b * (p2 - p1);
}
