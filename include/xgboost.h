#ifndef __XGBOOST_H
#define __XGBOOST_H

#include "tree_booster.h"

struct xgboost_classifier {
  struct tree_booster **trees;
};

struct xgboost_classifier *xgboost_init();
void free_xgb(struct xgboost_classifier *xgb);

void *get_gradients(struct matrix *y, struct matrix *y_pred);

struct xgboost_classifier *fit_xgb(struct matrix *X, struct matrix *y);
struct matrix *predict(struct xgboost_classifier *xgb, struct matrix *X);

#endif
