	global dot_product
	global add_matrices
	global scalar_multiplication
	global matrix_sum

	extern matrix_init
	extern seperate_matrix

dot_product:
	push ebp
	mov ebp, esp
	sub esp, 12
	push ebx
	push edi
	push esi

	mov eax, [ebp+20]
	mov edx, [eax]
	mov [ebp-12], edx	; ebp-12 = A rows
	mov edx, [eax+4]
	mov [ebp-8], edx	; ebp-8 = common dim

	mov eax, [ebp+24]
	cmp edx, [eax]
	jne invalid_dims
	
	mov edx, [eax+4]
	mov [ebp-4], edx	; ebp-4 = B cols

	mov eax, [ebp+8]
	mov edx, [ebp+12]

	xor esi, esi
i_loop:
	xor edi, edi
j_loop:
	xor ecx, ecx
	fldz
k_loop:
	mov ebx, esi
	imul ebx, [ebp-8]
	add ebx, ecx
	imul ebx, 4
	add ebx, eax
	fld dword[ebx]		; st(0) = a[i][k]

	mov ebx, ecx
	imul ebx, [ebp-4]
	add ebx, edi
	imul ebx, 4
	add ebx, edx
	fld dword[ebx]		; st(0) = b[k][j] st(1) = a[i][k] st(2) = sum

	fmulp
	faddp

	inc ecx
	cmp ecx, [ebp-8]
	jl k_loop

	mov ebx, esi
	imul ebx, [ebp-4]
	add ebx, edi
	imul ebx, 4
	add ebx, [ebp+16]
	fstp dword[ebx]

	inc edi
	cmp edi, [ebp-4]
	jl j_loop

	inc esi
	cmp esi, [ebp-12]
	jl i_loop
	
	
invalid_dims:	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret



add_matrices:
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ebx, eax

	push dword[ebp+12]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	add edx, 4
	imul ecx, [edx]

	;; eax = b->array
	;; ebx = a->array
	;; ecx = len

	xor esi, esi
add_loop:
	fld dword[eax]
	fld dword[ebx]
	faddp st1, st0

	fstp dword[ebx]

	add eax, 4
	add ebx, 4
	inc esi
	cmp esi, ecx
	jl add_loop
	
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret

scalar_multiplication:
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	add edx, 4
	imul ecx, [edx]

	fld dword[ebp+12]

	xor esi, esi
r_loop:
	fld dword[eax]
	fmul st0, st1

	fstp dword[eax]

	add eax, 4
	inc esi
	cmp esi, ecx
	jl r_loop

	fstp

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
