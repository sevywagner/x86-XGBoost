#include "utils.h"

void *array_init(size_t len, size_t var_size_bytes) {
  void *res = malloc(len * var_size_bytes);
  return res;
}


void free_array(void *array) {
  free(array);
}
