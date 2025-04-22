#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include "matrix.h"
#include "mask.h"
#include "utils.h"
#include "mathematics.h"
#include "tree_booster.h"
#include "xgboost.h"

void get_data(struct matrix *X, struct matrix *y);

int main() {
  struct matrix *X = matrix_init(300, 34);
  struct matrix *y = matrix_init(1, 300);
  
  get_data(X, y);
  
  struct xgboost_classifier *xgb = fit_xgb(X, y);

  struct matrix *sp = predict(xgb, X);

  float avg = 0.0;
  for (int i = 0; i < X->dims[0]; i++) {
    if ((sp->array[i] > .5 && y->array[i] == 1) || (sp->array[i] < .5 && y->array[i] == 0)) {
      avg += 1.0;
    }
  }

  printf("Accuracy: %.3f\n", avg / X->dims[0]);

  free_xgb(xgb);
  free_matrix(sp);
  free_matrix(X);
  free_matrix(y);
  
  return 0;
}

void get_data(struct matrix *X, struct matrix *y) {
  FILE *fptr = fopen("./data/ion.tsv", "r");
  if (fptr == NULL) {
    printf("Probrem\n");
  }
  float *xp = X->array;
  float *yp = y->array;

  int rows = X->dims[0];
  int cols = X->dims[1];

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      char c[10];
      int ctr = 0;
      while ((c[ctr] = fgetc(fptr)) != '\t') {
        ctr++;
      }

      float val = atof(c);
      *xp = val;
      xp += 1;
    }
    
    float val = (float) (fgetc(fptr) - '0');
    fgetc(fptr);
    *yp = val;
    yp += 1;
    
  }

  fclose(fptr);
}
