	section .text
	global fit_xgb

	extern xgboost_init
	extern matrix_init
	extern get_gradients
	extern fit_tree
	extern get_row
	extern free_matrix
	extern free
	extern tree_predict_sample
	extern seperate_matrix
	extern generate_random_mask
	extern apply_mask
	extern free_mask

	extern LEARNING_RATE
	extern N_LEARNERS
	extern SUBSAMPLE_FACTOR
fit_xgb:
	push ebp
	mov ebp, esp
	sub esp, 36
	push ebx
	push edi
	push esi

	call xgboost_init

	mov [ebp-4], eax

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	mov [ebp-8], ecx

	push ecx
	push 1
	call matrix_init
	add esp, 8

	mov [ebp-12], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-16], eax

	xor esi, esi
init_loop:
	fldz
	fstp dword[eax]
	add eax, 4
	inc esi
	cmp esi, [ebp-8]
	jl init_loop

	;; ebp-4 = *res
	;; ebp-8 = len
	;; ebp-12 = *fm
	;; ebp-16 = fm->array

	xor esi, esi
i_loop:	
	push dword[ebp-12]
	push dword[ebp+12]
	call get_gradients
	add esp, 8

	mov ecx, [eax]
	mov [ebp-20], ecx

	add eax, 4
	mov ecx, [eax]
	mov [ebp-24], ecx

	sub eax, 4
	push eax
	call free
	add esp, 4

	push 0
	push dword[ebp-24]
	push dword[ebp-20]
	push dword[ebp+8]
	call fit_tree
	add esp, 16

	mov [ebp-28], eax
	mov ebx, [ebp-16]

	xor edi, edi
j_loop:
	push edi
	push dword[ebp+8]
	call get_row
	add esp, 8

	mov [ebp-32], eax
	
	push eax
	push dword[ebp-28]
	call tree_predict_sample
	add esp, 8

	fld dword[LEARNING_RATE]
	fmulp

	fld dword[ebx]
	faddp

	fstp dword[ebx]

	push dword[ebp-32]
	call free_matrix
	add esp, 4

	add ebx, 4
	inc edi
	cmp edi, [ebp-8]
	jl j_loop

	mov eax, [ebp-4]
	mov eax, [eax]

	mov edx, esi
	shl edx, 2
	add edx, eax

	mov ecx, [ebp-28]
	mov [edx], ecx

	push dword[ebp-20]
	call free_matrix
	add esp, 4

	push dword[ebp-24]
	call free_matrix
	add esp, 4

	inc esi
	cmp esi, [N_LEARNERS]
	jl i_loop

done:	
	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
