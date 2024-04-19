#include <stdio.h>
#include "add.h"

int main() {
    int result;
    result = add(10, 20); // Add function is defined in asm file
    printf("Function add(..) Result: %i\n", result);
    return 0;
}