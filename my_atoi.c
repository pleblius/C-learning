#include <limits.h>
#include <stdio.h>

int is_number(char);
int to_number(char);
int check_overflow(int, int, int);
int myAtoi(char*);

int main() {
    int i = myAtoi("5");
    printf("%d", i);

    return 0;
}

int myAtoi(char* s) {
    int sign = 1;
    int sum = 0;
    char c = *s;

    while (c != '\0') {
        printf("%d\n", to_number(c));
        while (c == ' ') {
            c = *(++s);
        }

        if (is_number(c)) break;
        else {
            if (c == '+') sign = 1;
            else if (c == '-') sign = -1;
            else return 0;

            c = *(++s);
            break;
        }
    }

    while (c != '\0') {
        printf("%d\n", to_number(c));
        if (is_number(c)) {
            if (check_overflow(sum, to_number(c), sign)) {
                if (sign > 0) return INT_MAX;
                else return INT_MIN;
            }

            sum *= 10;
            sum += sign * to_number(c);
        }
        else break;

        c = *(++s);
    }

    return sum;
}

int is_number(char c) {
    if (c >= '0' && c <= '9') return 1;

    return 0;
}

int to_number(char c) {
    return c - '0';
}

int check_overflow(int num, int add, int sign) {
    if (sign > 0) {
        return (INT_MAX - add) / 10 < num;
    }
    else if (sign < 0) {
        return (INT_MIN + add) / 10 > num;
    }
    
    return 0;
}
