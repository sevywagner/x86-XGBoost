#ifndef __MASK_H
#define __MASK_H

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>

#include "matrix.h"

enum mask_operation {
  GT,
  GTE,
  LT,
  LTE,
  EQ,
  NEQ
};

enum mask_type {
  IDX,
  BIN
};

struct mask {
  enum mask_type type;
  uint32_t n_ones;
  int *array;
};

struct mask *mask_init(size_t len);
void free_mask(struct mask *mask);

struct mask *generate_mask(struct matrix *m, enum mask_operation mt, enum mask_type type, float val);
struct mask *generate_arange_idx_mask(uint32_t range);
struct mask *generate_random_mask(uint32_t samples, uint32_t start, uint32_t end, uint32_t len);

struct matrix *apply_mask(struct matrix *m, struct mask *mask);

#endif