#include <stdio.h>

char multiply(char multiplicant, char multiplier) // parameters should be defined beforehand
{
    if (multiplier == 0 || multiplicant == 0) // early return if 0
    {
        return 0;
    }

    char product = 0;
    char neg = 0;

    if (multiplicant >> 7) // if multiplicant(7) == 1
    {
        multiplicant = ~multiplicant + 1; // quotient = -quotient, 2's complement
        neg = neg ^ 1;                    // neg = neg xor 1
    }

    if (multiplier >> 7) // multiplier(7) == 1
    {
        multiplier = ~multiplier + 1; // multiplier = -multiplier, 2's complement
        neg = neg ^ 1;                // neg = neg xor 1
    }

    for (int i = 0; i < 4; i++) // int i <- 0, until 4
    {
        if (multiplier & 1) // if multiplier(0) == 1
        {
            product = product + multiplicant;
        }

        multiplicant = multiplicant << 1;
        multiplier = multiplier >> 1;
    }

    if (neg) // neg(0) == 1
    {
        product = ~product + 1; // product = -product, 2's complement
    }
    else
    {
        product & 0x7f; // product(7) = 0
    }

    return product;
}

char divide(char dividend, char divisor)
{
    if (divisor == 0) // early return if divisor 0
    {
        return 0;
    }

    char quotient = 0;
    char count = 7;                // number of bits - 1, change to 3 for 4 bits
    char remainder = dividend >> count;
    char neg = 0;

    if (dividend >> 7) // dividend(7) == 1
    {
        dividend = ~dividend + 1; // dividend = -dividend, 2's complement
        neg = neg ^ 1;            // neg = neg xor 1
    }

    if (divisor >> 7) // divisor(7) == 1
    {
        divisor = ~divisor + 1; // divisor = -divisor, 2's complement
        neg = neg ^ 1;          // neg = neg xor 1
    }

    remainder = dividend >> count; // set remainder to MSB
    while (count > -1)             // loop N bit times, we are going from MSB to LSB
    {
        if (divisor <= remainder)
        {
            quotient = quotient | (1 << count); // quotient(count) = 1
            remainder = remainder - divisor;
        }
        remainder = remainder << 1;                            // concat the bit to the right of the dividend to the remainder
        remainder = ((dividend >> count - 1) & 1) | remainder; // remainder(0) = dividend(count - 1)

        count--; // move on to the next bit to the right
    }

    if (neg) // if neg(0) == 1
    {
        quotient = ~quotient + 1; // quotient = -quotient, 2's complement
    }
    else
    {
        quotient & 0x7f; // quotient(7) = 0
    }

    return quotient;
}

int main(int argc, char const *argv[])
{
    printf("%d\n", multiply(12, -3));
    printf("%d\n", divide(126, 9));
    return 0;
}
