#include "xgboost.h"

struct xgboost_classifier *xgboost_init() {
  struct xgboost_classifier *res = (struct xgboost_classifier *) malloc(sizeof(struct xgboost_classifier));
  struct tree_booster **xgb_trees = (struct tree_booster **) malloc(sizeof(struct tree_booster *) * N_LEARNERS);
  res->trees = xgb_trees;
  return res;
}

void free_xgb(struct xgboost_classifier *xgb) {
  for (int i = 0; i < N_LEARNERS; i++) {
    free_tree(xgb->trees[i]);
  }
  free(xgb->trees);
  free(xgb);
}
