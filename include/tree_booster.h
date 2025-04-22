#ifndef __TREE_BOOSTER_H
#define __TREE_BOOSTER_H

#include "matrix.h"
#include "xgboost_config.h"
#include <stdint.h>

struct tree_booster {
  struct tree_booster *left;
  struct tree_booster *right;
  float best_gain;
  uint32_t best_feature;
  float best_threshold;
  float value;
};

struct tree_booster *tree_booster_init();
void free_tree(struct tree_booster *tb);

float sigmoid(float val);
struct matrix *sigmoid_matrix(struct matrix *m);

float get_value(struct matrix *gradients, struct matrix *hessians);
float get_gain(float gradients, float hessians, float grad_left, float hess_left, float grad_right, float hess_right);
void find_best_split(struct tree_booster *tb, struct matrix *X, struct matrix *gradients, struct matrix *hessians);

struct tree_booster *fit_tree(struct matrix *x, struct matrix *g, struct matrix *h, uint32_t depth);
float tree_predict_sample(struct tree_booster *tb, struct matrix *sample);
float *tree_predict(struct tree_booster *tb, struct matrix *samples);

void traverse(struct tree_booster *tb);

#endif
