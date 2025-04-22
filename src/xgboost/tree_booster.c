#include "tree_booster.h"

struct tree_booster *tree_booster_init() {
  struct tree_booster *res = (struct tree_booster *) malloc(sizeof(struct tree_booster));
  res->left = NULL;
  res->right = NULL;
  return res;
}

void traverse(struct tree_booster *tb) {
  if (tb->left != NULL) {
    traverse(tb->left);
  }

  printf("%.3f, %.3f\n", tb->value, tb->best_gain);

  if (tb->right != NULL) {
    traverse(tb->right);
  }
}

void free_tree(struct tree_booster *tb) {
  if (tb->left != NULL) {
    free_tree(tb->left);
  }

  if (tb->right != NULL) {
    free_tree(tb->right);
  }

  free(tb);
}
