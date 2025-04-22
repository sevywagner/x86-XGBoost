#include "mask.h"

struct mask *mask_init(size_t len) {
  struct mask *res = (struct mask *) malloc(sizeof(struct mask));
  res->array = (int *) malloc(sizeof(int) * len);
  return res;
}

void free_mask(struct mask *mask) {
  free(mask->array);
  free(mask);
}
