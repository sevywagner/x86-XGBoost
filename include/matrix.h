#ifndef __ASNUM_H
#define __ASNUM_H

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

struct matrix {
  uint32_t *dims;
  float *array;
};

struct matrix *matrix_dec(uint32_t *dims, float *array);
struct matrix *matrix_init(uint32_t rows, uint32_t cols);
void free_matrix(struct matrix *m);

void print_matrix(struct matrix *m);

void dot_product(float *a, float *b, float *prod, uint32_t *dims1, uint32_t *dims2);
void scalar_multiplication(struct matrix *a, float scalar);
void add_matrices(struct matrix *a, struct matrix *b);

float sum(struct matrix *m);

void sort(struct matrix *m);
void *argsort(struct matrix *m);

struct matrix *get_column(struct matrix *m, uint32_t col);
struct matrix *get_row(struct matrix *m, uint32_t row);

struct matrix *transpose(struct matrix *m);

#endif
