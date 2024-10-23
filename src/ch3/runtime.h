// At several points in our compiler we have decided to rely on the
// fact that pointers are 64 bits wide. The stdint.h header file
// declares a platform aware type that is guaranteed to contain
// 64 bits.
#include <stdint.h>

// Read an integer from stdin.
int64_t read_int();

// Print an integer to stdout.
void print_int(int64_t x);

