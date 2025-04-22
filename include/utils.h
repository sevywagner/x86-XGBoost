#ifndef __UTILS_H
#define __UTILS_H

#include <stddef.h>
#include "matrix.h"

void seperate_matrix(struct matrix *m);

void *array_init(size_t len, size_t var_len_bytes);
void *copy_array(void *src, size_t len, size_t var_size_bytes);
void free_array(void *array);

uint32_t gen_unsigned_random(uint32_t start, uint32_t end);

#endif
