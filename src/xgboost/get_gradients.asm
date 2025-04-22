	section .data
one:	dd	1
	
	section .text
	global get_gradients

	extern array_init
	extern matrix_init
	extern free_matrix
	extern sigmoid_matrix
	extern seperate_matrix
	extern free_array
	
get_gradients:
	push ebp
	mov ebp, esp
	sub esp, 20
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov [ebp-12], eax

	add edx, 4
	push dword[edx]
	sub edx, 4
	push dword[edx]
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-16], eax

	add edx, 4
	push dword[edx]
	sub edx, 4
	push dword[edx]
	call matrix_init
	add esp, 8

	mov [ebp-8], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov edi, eax

	push dword[ebp+12]
	call sigmoid_matrix
	add esp, 4

	mov [ebp-20], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov ebx, [ebp-12]
	mov ecx, [edx]
	mov edx, [ebp-16]

	;; eax = sigmoid_matrix->array
	;; ebx = y->array
	;; ecx = len
	;; edx = grad->array
	;; edi = hess->array
	;; ebp-4 = *grad
	;; ebp-8 = *hess
	;; ebp-12 = y->array
	;; ebp-20 = *sigmoid_matrix

	xor esi, esi
i_loop:
	fld dword[eax]
	fld dword[ebx]
	fsubp st1, st0

	fstp dword[edx]

	fild dword[one]
	fld dword[eax]
	fsubp st1, st0

	fld dword[eax]
	fmulp

	fstp dword[edi]

	add eax, 4
	add ebx, 4
	add edx, 4
	add edi, 4

	inc esi
	cmp esi, ecx
	jl i_loop

	push dword[ebp-20]
	call free_matrix
	add esp, 4

	push 4
	push 2
	call array_init
	add esp, 8

	mov edx, [ebp-4]
	mov [eax], edx
	add eax, 4
	mov edx, [ebp-8]
	mov [eax], edx

	sub eax, 4
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
