#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int get_roll();
int get_return(int, int);

int main() {
    long start = 10000000;
    long winnings = 0;
    long i;

    for (i = 0; i < start/2; ++i) {
        winnings += get_return(2, get_roll());    
    }

    printf("Total bet: %d\nWinnings: %d\n", start, winnings);

    float winrate = -1 * 0.5 + 0 * .25 + 1 * .23 + 24 * .02;
    float payout = 0 * 0.5 + 1 * .25 + 2 * .23 + 25 * .02;
    printf("return rate: %f \npayout: %f \n", winrate, payout);

    return 0;
}

int get_roll() {
    return rand() % (100) + 1;
}

int get_return(int bet, int roll) {
    if (roll < 1 || roll > 100) printf("invalid roll");

    if (roll <= 50) {
        return 0;
    }
    else if (roll <= 75) {
        return bet;
    }
    else if (roll <= 98) {
        return 2 * bet;
    }
    else if (roll <= 100) {
        return 25 * bet;
    }
}
