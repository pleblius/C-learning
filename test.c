#include <stdio.h>

int main() {
    return 0;
}

int f1 (int x, int y) {
    if (x+y) return 0;
    return 1;
}

unsigned int f2 (unsigned int y, unsigned int x) {
    if (x >= y) return x;
    return y;
}

int f3 (int y, int x) {
    if (x || y) return 1;
    return 0;
}

int f4 (int x, int y) {
    if (x-1 || y-1) 
        return 0;
    return 1;
}

int myloop (int x, int y) {
    int result = 0;

    while (y <= x) {
        y = 8*(3*y - 1);
        result += y;
    }
    return result;
}

int fn_jt (int x, int y) {
    int result = 0;
    switch(x) {
        case 3:
        case 5:
            result = 7 * y;
            break;
        case 6:
        case 7:
            result = x-y;
        case 8:
            result = result - x;
            break;
        default:
            result = x*8;
    }

    return result;
}

int mat1[11][47];
int mat2[47][11];

int sum_element(int i, int j) {
    return mat1[i][j] + mat2[i][j];
}
