#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IS_ODD(i) (i^((i >> 1) << 1))
#define IS_UPPER(c) (c<= 90 && c >= 65)
#define IS_DECIMAL(c) (c >= 48 && c <= 57)

int a_flag = 1;
int b_flag = 0, c_flag = 0, t_flag = 0;

void print_arg(char*);
int a_match(char*);
int b_match(char*);
int c_match(char*);
char get_last_char(char*);

int main (int argc, char* argv[]) {
    char c;

    // Loop through args looking for flags. Ignores first arg (filename)
    for (; argc > 1; --argc) {
        if ((*++argv)[0] == '-') {
            c = *++argv[0];

            switch (c) {
                case ('a'):
                    a_flag = 1;
                    break;
                case ('b'):
                    b_flag = 1;
                    a_flag = 0;
                    break;
                case ('c'):
                    c_flag = 1;
                    a_flag = 0;
                    break;
                case ('t'):
                    t_flag = 1;
                    break;
            }
        } // If not a flag, it's an argument
        else {
            print_arg(argv[0]);
        }        
    }

    return 0;
}

/*
    Prints the string stored at p_char.
    Checks if the string matches the current flag (-a, -b, or -c) and prints it according to
    the rules governed by the -t flag.
*/
void print_arg(char* p_char) {
    if (!p_char) return;
    
    char c;
    char* print_string;
    unsigned int pos = 0;
    
    // 1: -a is flagged and is a match
    if (a_flag && a_match(p_char)) {
        if (!t_flag) printf("yes");
        else {
            c = get_last_char(p_char);

            // Create dynamic array to minimize print calls
            print_string = malloc((strlen(p_char) + 1) * sizeof(char));
            if (!print_string) exit(1);
            
            // Fill array with final character. Null terminated.
            while (*p_char++) print_string[pos++] = c;
            print_string[pos] = '\0';

            printf("%s", print_string);
            free(print_string);
        }
    } // 2: -b is flagged and is a match 
    else if (b_flag && b_match(p_char)) {
        if (!t_flag) printf("yes");
        else {
            // Create dynamic array - 2x as long as original
            print_string = malloc(2 * (strlen(p_char) + 1) * sizeof(char));
            if (!print_string) exit(1);

            // Alternate original char and pos%8
            while ((c = *(p_char++))) {
                print_string[pos++] = c;
                print_string[pos] = ((7 & pos>>1) + 48);
                ++pos;
            }
            print_string[pos] = '\0';

            printf("%s", print_string);
            free (print_string);
        }
    } // 3: -c is flagged and is a match 
    else if (c_flag && c_match(p_char)) {
        if (!t_flag) printf("yes");
        else {
            print_string = malloc((strlen(p_char) + 1) * sizeof(char));
            if (!print_string) exit(1);
            
            while ((c = *p_char++)) 
                if (c != 'E' && c != 'G') print_string[pos++] = c;
            print_string[pos] = '\0';

            printf("%s", print_string);
            free(print_string);
        }
    } // 4: no match and -t is NOT flagged
    else if (!t_flag) {
        printf("no");
    } else return; // default: no match and -t is flagged. No output.

    putchar('\n');
}

/*
    Checks if the string at p_char is a match according to the rules of the -a flag.
    Returns 1 if the string is a match. Returns 0 otherwise.
*/
int a_match(char* p_char) {
    if (!p_char) return 0;

    int count = 0;

    // 1: Odd number of c's at beginning of string.
    while (*p_char == 'c') {
        ++count;
        ++p_char;
    }
    if (!IS_ODD(count)) return 0;
    count = 0;

    // 2: Exactly one '='
    if (*p_char++ != '=') return 0;

    // 3: 2-5 repeated 'r'
    while (*p_char == 'r') {
        ++count;
        ++p_char;
    }
    if (count > 5 || count < 2) return 0;
    count = 0;

    // 4: Exactly one ','
    if (*p_char++ != ',') return 0;

    // 5: Odd number of uppercase letters
    while (IS_UPPER(*p_char)) {
        ++count;
        ++p_char;
    }

    // Check if end of string
    return IS_ODD(count) && !*p_char;
}

/*
    Checks if the string at p_char is a match according to the rules of the -b flag.
    Returns 1 if the string is a match. Returns 0 otherwise.
*/
int b_match(char* p_char) {
    if (!p_char) return 0;

    int count = 0;
    char *x_start, *x_end;

    // 1: Any number of 'g', including 0
    while (*p_char == 'g') ++p_char;

    // 2: Exactly one ','
    if (*p_char++ != ',') return 0;

    // 3: Odd number of uppercase letters - Sequence X
    x_start = p_char; // Start of sequence X
    while (IS_UPPER(*p_char)) {
        ++p_char;
        ++count;
    }
    x_end = p_char; // End of sequence X
    if (!IS_ODD(count)) return 0;
    count = 0;

    // 4: Three+ 'w'
    while (*p_char == 'w') {
        ++count;
        ++p_char;
    }
    if (count < 3) return 0;
    count = 0;

    // 5: Exactly one '_'
    if (*p_char++ != '_') return 0;

    // 6: X but reversed
    while (x_end > x_start) {
        if (*p_char++ != *--x_end) return 0;
    }

    // 7: 1-3 digits
    while (IS_DECIMAL(*p_char)) {
        ++count;
        ++p_char;
    }

    // Check for end of string
    return count <=3 && count >=1 && !*p_char;
}

/*
    Checks if the string at p_char is a match according to the rules of the -c flag.
    Returns 1 if the string is a match. Returns 0 otherwise.
*/
int c_match(char* p_char) {
    if (!p_char) return 0;

    int count = 0;
    char *x_start, *x_end;

    // 1: Odd number of 'j'
    while (*p_char == 'j') {
        ++count;
        ++p_char;
    }
    if (!IS_ODD(count)) return 0;
    count = 0;

    // 2: Exactly one '_'
    if (*p_char++ != '_') return 0;

    // 3: Odd number of uppercase letters - Sequence X
    x_start = p_char; // Start of sequence X
    while (IS_UPPER(*p_char)) {
        ++p_char;
        ++count;
    }
    x_end = p_char; // End of sequence X
    if (!IS_ODD(count)) return 0;
    count = 0;

    // 4: Odd number of 'u'
    while (*p_char == 'u') {
        ++count;
        ++p_char;
    }
    if (!IS_ODD(count)) return 0;
    count = 0;

    // 5: Exactly one '_'
    if (*p_char++ != '_') return 0;

    // 6: Same characters as odd positioned characters in X
    while (++x_start < x_end) {
        if (*p_char++ != *(x_start++)) return 0;
    }

    // 7: 1-3 digits
    while (IS_DECIMAL(*p_char)) {
        ++count;
        ++p_char;
    }

    // Check for end of string
    return count >= 1 && count <=3 && !*p_char;
}

/*
    Gets the last character of the string stored at p_char.
    Assumes string is null terminated.
    If string is empty or pointer is null, returns terminator.
*/
char get_last_char(char* p_char) {
    if (!p_char || !*p_char) return '\0';

    while (*(++p_char));

    return *(p_char - 1);
}
