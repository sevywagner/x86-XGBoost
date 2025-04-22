FILES = ./build/matrix.asm.o ./build/matrix.o ./build/main.o ./build/sort.asm.o ./build/utils.asm.o ./build/gen_mask.asm.o ./build/mask.o ./build/apply_mask.asm.o ./build/sum.asm.o ./build/gen_arange_idx_mask.asm.o ./build/argsort.asm.o ./build/utils.o ./build/copy_array.asm.o ./build/sigmoid.asm.o ./build/e_exp.asm.o ./build/sigmoid_matrix.asm.o ./build/get_gain.asm.o ./build/get_column.asm.o ./build/find_best_split.asm.o ./build/get_gradients.asm.o ./build/transpose.asm.o ./build/get_value.asm.o ./build/fit_tree.asm.o ./build/tree_booster.o ./build/tree_predict_sample.asm.o ./build/get_row.asm.o ./build/tree_predict.asm.o ./build/xgboost.o ./build/gen_unsigned_random.asm.o ./build/generate_random_mask.asm.o ./build/fit_xgb.asm.o ./build/predict.asm.o ./build/xgboost_config.o

INCLUDE = ./include
ASNUM_DIR = ./src/asnum
XGB_DIR = ./src/xgboost
MATH_DIR = ./src/mathematics

./build/main: $(FILES)
	gcc -no-pie -m32 $(FILES) -o ./build/main -z noexecstack



./build/matrix.asm.o: $(ASNUM_DIR)/matrix/matrix.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/matrix.asm -o ./build/matrix.asm.o

./build/matrix.o: $(ASNUM_DIR)/matrix/matrix.c
	gcc -m32 -I $(INCLUDE) -c $(ASNUM_DIR)/matrix/matrix.c -o ./build/matrix.o

./build/sort.asm.o: $(ASNUM_DIR)/matrix/sort.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/sort.asm -o ./build/sort.asm.o

./build/sum.asm.o: $(ASNUM_DIR)/matrix/sum.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/sum.asm -o ./build/sum.asm.o

./build/argsort.asm.o: $(ASNUM_DIR)/matrix/argsort.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/argsort.asm -o ./build/argsort.asm.o

./build/get_column.asm.o: $(ASNUM_DIR)/matrix/get_column.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/get_column.asm -o ./build/get_column.asm.o

./build/transpose.asm.o: $(ASNUM_DIR)/matrix/transpose.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/transpose.asm -o ./build/transpose.asm.o

./build/get_row.asm.o: $(ASNUM_DIR)/matrix/get_row.asm
	nasm -f elf32 $(ASNUM_DIR)/matrix/get_row.asm -o ./build/get_row.asm.o



./build/utils.asm.o: ./src/utils/utils.asm
	nasm -f elf32 ./src/utils/utils.asm -o ./build/utils.asm.o

./build/utils.o: ./src/utils/utils.c
	gcc -m32 -I $(INCLUDE) -c ./src/utils/utils.c -o ./build/utils.o

./build/copy_array.asm.o: ./src/utils/copy_array.asm
	nasm -f elf32 ./src/utils/copy_array.asm -o ./build/copy_array.asm.o

./build/gen_unsigned_random.asm.o: ./src/utils/gen_unsigned_random.asm
	nasm -f elf32 ./src/utils/gen_unsigned_random.asm -o ./build/gen_unsigned_random.asm.o



./build/gen_mask.asm.o: $(ASNUM_DIR)/mask/gen_mask.asm
	nasm -f elf32 $(ASNUM_DIR)/mask/gen_mask.asm -o ./build/gen_mask.asm.o

./build/apply_mask.asm.o: $(ASNUM_DIR)/mask/apply_mask.asm
	nasm -f elf32 $(ASNUM_DIR)/mask/apply_mask.asm -o ./build/apply_mask.asm.o

./build/mask.o: $(ASNUM_DIR)/mask/mask.c
	gcc -m32 -I $(INCLUDE) -c $(ASNUM_DIR)/mask/mask.c -o ./build/mask.o

./build/gen_arange_idx_mask.asm.o: $(ASNUM_DIR)/mask/gen_arange_idx_mask.asm
	nasm -f elf32 $(ASNUM_DIR)/mask/gen_arange_idx_mask.asm -o ./build/gen_arange_idx_mask.asm.o

./build/generate_random_mask.asm.o: $(ASNUM_DIR)/mask/generate_random_mask.asm
	nasm -f elf32 $(ASNUM_DIR)/mask/generate_random_mask.asm -o ./build/generate_random_mask.asm.o



./build/sigmoid.asm.o: $(XGB_DIR)/sigmoid.asm
	nasm -f elf32 $(XGB_DIR)/sigmoid.asm -o ./build/sigmoid.asm.o

./build/sigmoid_matrix.asm.o: $(XGB_DIR)/sigmoid_matrix.asm
	nasm -f elf32 $(XGB_DIR)/sigmoid_matrix.asm -o ./build/sigmoid_matrix.asm.o

./build/get_gain.asm.o: $(XGB_DIR)/get_gain.asm
	nasm -f elf32 $(XGB_DIR)/get_gain.asm -o ./build/get_gain.asm.o

./build/find_best_split.asm.o: $(XGB_DIR)/find_best_split.asm
	nasm -f elf32 $(XGB_DIR)/find_best_split.asm -o ./build/find_best_split.asm.o

./build/get_gradients.asm.o: $(XGB_DIR)/get_gradients.asm
	nasm -f elf32 $(XGB_DIR)/get_gradients.asm -o ./build/get_gradients.asm.o

./build/get_value.asm.o: $(XGB_DIR)/get_value.asm
	nasm -f elf32 $(XGB_DIR)/get_value.asm -o ./build/get_value.asm.o

./build/fit_tree.asm.o: $(XGB_DIR)/fit_tree.asm
	nasm -f elf32 $(XGB_DIR)/fit_tree.asm -o ./build/fit_tree.asm.o

./build/tree_booster.o: $(XGB_DIR)/tree_booster.c
	gcc -m32 -I $(INCLUDE) -c $(XGB_DIR)/tree_booster.c -o ./build/tree_booster.o

./build/tree_predict_sample.asm.o: $(XGB_DIR)/tree_predict_sample.asm
	nasm -f elf32 $(XGB_DIR)/tree_predict_sample.asm -o ./build/tree_predict_sample.asm.o

./build/xgboost_config.o: $(XGB_DIR)/xgboost_config.c
	gcc -m32 -I $(INCLUDE) -c $(XGB_DIR)/xgboost_config.c -o ./build/xgboost_config.o


./build/tree_predict.asm.o: $(XGB_DIR)/tree_predict.asm
	nasm -f elf32 $(XGB_DIR)/tree_predict.asm -o ./build/tree_predict.asm.o

./build/xgboost.o: $(XGB_DIR)/xgboost.c
	gcc -m32 -I $(INCLUDE) -c $(XGB_DIR)/xgboost.c -o ./build/xgboost.o

./build/fit_xgb.asm.o: $(XGB_DIR)/fit_xgb.asm
	nasm -f elf32 $(XGB_DIR)/fit_xgb.asm -o ./build/fit_xgb.asm.o

./build/predict.asm.o: $(XGB_DIR)/predict.asm
	nasm -f elf32 $(XGB_DIR)/predict.asm -o ./build/predict.asm.o



./build/e_exp.asm.o: $(MATH_DIR)/e_exp.asm
	nasm -f elf32 $(MATH_DIR)/e_exp.asm -o ./build/e_exp.asm.o



./build/main.o: ./src/main.c
	gcc -m32 -I $(INCLUDE) -c ./src/main.c -o ./build/main.o



clean:
	rm ./build/*.o
	rm ./build/main
