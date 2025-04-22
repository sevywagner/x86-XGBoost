	section .text
	global predict

	extern get_row
	extern matrix_init
	extern tree_predict_sample
	extern sigmoid_matrix
	extern seperate_matrix
	extern free_matrix

	extern LEARNING_RATE
	extern N_LEARNERS
predict:
	push ebp
	mov ebp, esp
	sub esp, 20
	push ebx
	push edi
	push esi

	push dword[ebp+12]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	mov [ebp-20], ecx

	push ecx
	push 1
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-8], eax
	mov edx, eax

	xor esi, esi
init_loop:
	fldz
	fstp dword[edx]
	add edx, 4
	inc esi
	cmp esi, [ebp-20]
	jl init_loop
	
	xor esi, esi
i_loop:
	xor edi, edi
	mov ebx, [ebp-8]

	mov eax, [ebp+8]
	mov eax, [eax]

	mov edx, esi
	shl edx, 2
	add edx, eax
	mov edx, [edx]
	mov [ebp-12], edx
	
j_loop:
	
	push edi
	push dword[ebp+12]
	call get_row
	add esp, 8

	mov [ebp-16], eax

	push ebx
	push eax
	push dword[ebp-12]
	call tree_predict_sample
	add esp, 8
	pop ebx

	fld dword[LEARNING_RATE]
	fmulp

	fld dword[ebx]
	faddp

	fstp dword[ebx]

	push dword[ebp-16]
	call free_matrix
	add esp, 4

	add ebx, 4
	inc edi
	cmp edi, [ebp-20]
	jl j_loop

	inc esi
	cmp esi, [N_LEARNERS]
	jl i_loop

	push dword[ebp-4]
	call sigmoid_matrix
	add esp, 4

	mov ebx, eax

	push dword[ebp-4]
	call free_matrix
	add esp, 4

	mov eax, ebx

	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
