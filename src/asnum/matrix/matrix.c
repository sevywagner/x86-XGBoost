#include "matrix.h"

struct matrix *matrix_dec(uint32_t *dims, float *array) {
  struct matrix *res = (struct matrix *) malloc(sizeof(struct matrix));
  res->dims = dims;
  res->array = array;
  return res;
}

struct matrix *matrix_init(uint32_t rows, uint32_t cols) {
  struct matrix *res = (struct matrix *) malloc(sizeof(struct matrix));
  res->dims = (uint32_t *) malloc(sizeof(uint32_t) * 2);
  res->dims[0] = rows;
  res->dims[1] = cols;
  res->array = (float *) malloc(sizeof(float) * rows * cols);
  return res;
}

void free_matrix(struct matrix *m) {
  free(m->dims);
  free(m->array);
  free(m);
}

void print_matrix(struct matrix *m) {
  uint32_t *dims = m->dims;
  float *arr = m->array;

  for (int i = 0; i < dims[0]; i++) {
    for (int j = 0; j < dims[1]; j++) {
      printf("%.10f, ", arr[i * dims[1] + j]);
    }
    printf("\n");
  }
}
