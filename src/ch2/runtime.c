#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "runtime.h"

// Read an integer from stdin.
int64_t read_int() {
  int64_t i;
  scanf("%" SCNd64, &i);
  return i;
}

// Print an integer to stdout.
void print_int(int64_t x) {
  printf("%" PRId64, x);
  printf("\n");
}

