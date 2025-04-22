	section .text
	global find_best_split

	extern seperate_matrix
	extern get_column
	extern argsort
	extern sum
	extern apply_mask
	extern free_matrix
	extern get_gain
	extern array_init
	extern free_mask
find_best_split:
	push ebp
	mov ebp, esp
	sub esp, 200
	push ebx
	push edi
	push esi

	push dword[ebp+12]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	dec ecx
	mov [ebp-76], ecx

	add edx, 4
	mov ecx, [edx]
	mov [ebp-80], ecx

	fldz

	push dword[ebp+16]
	call sum
	add esp, 4

	push dword[ebp+20]
	call sum
	add esp, 4

	mov dword[ebp-8], 0
	mov dword[ebp-12], 0

	;; st0 = hs
	;; st1 = gs
	;; st2 = best_gain
	;; ebp - 8 = best_feature
	;; ebp - 12 = best_feature

	xor esi, esi
i_loop:
	fldz
	fldz

	fsave [ebp-200]

	push esi
	push dword[ebp+12]
	call get_column
	add esp, 8

	mov [ebp-16], eax

	push eax
	call argsort
	add esp, 4

	mov [ebp-20], eax
	mov ebx, eax

	push ebx
	push dword[ebp+16]
	call apply_mask
	add esp, 8

	mov [ebp-24], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-28], eax

	push ebx
	push dword[ebp+20]
	call apply_mask
	add esp, 8

	mov [ebp-32], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-36], eax

	push ebx
	push dword[ebp-16]
	call apply_mask
	add esp, 8

	mov [ebp-40], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-44], eax

	;; ebp-16 = column
	;; ebp-20 = mask
	;; ebp-24 = *g_sort
	;; ebp-28 = g_sort->array
	;; ebp-32 = *h_sort
	;; ebp-36 = h_sort->array
	;; ebp-40 = *x_sort
	;; ebp-44 = x_sort->array

	;; st0 = hl
	;; st1 = gl
	;; st2 = hs
	;; st3 = gs
	;; st4 = best_gain

	frstor [ebp-200]

	xor edi, edi
j_loop:
	mov eax, edi
	shl eax, 2
	mov ecx, eax
	add eax, [ebp-28]
	fld dword[eax]

	faddp st2, st0

	mov eax, ecx
	add eax, [ebp-36]
	fld dword[eax]

	faddp st1, st0

	fld st3
	fld st2
	fsubp st1, st0

	fld st3
	fld st2
	fsubp st1, st0

	fstp dword[ebp-48]
	fstp dword[ebp-52]
	fstp dword[ebp-56]
	fstp dword[ebp-60]
	fstp dword[ebp-64]
	fstp dword[ebp-68]
	fstp dword[ebp-72]

	push dword[ebp-48]
	push dword[ebp-52]
	push dword[ebp-56]
	push dword[ebp-60]
	push dword[ebp-64]
	push dword[ebp-68]
	call get_gain
	add esp, 24
	
	fld dword[ebp-68]
	fld dword[ebp-64]
	fld dword[ebp-60]
	fld dword[ebp-56]
	fld dword[ebp-72]

	;; st0 = best_gain
	;; st1 = hl
	;; st2 = gl
	;; st3 = hs
	;; st4 = gs
	;; st5 = gain

	fcomi st0, st5
	jbe new_best_gain

	fxch st0, st5
	jmp increment_j
	
new_best_gain:
	mov [ebp-8], esi

	mov eax, edi
	shl eax, 2
	add eax, [ebp-44]
	fld dword[eax]
	fstp dword[ebp-12]

increment_j:
	fstp st0

	inc edi
	cmp edi, [ebp-76]
	jl j_loop

	push dword[ebp-16]
	call free_matrix
	add esp, 4

	push dword[ebp-20]
	call free_mask
	add esp, 4

	push dword[ebp-24]
	call free_matrix
	add esp, 4

	push dword[ebp-32]
	call free_matrix
	add esp, 4

	push dword[ebp-40]
	call free_matrix
	add esp, 4

	fstp st0
	fstp st0
	
	inc esi
	cmp esi, [ebp-80]
	jl i_loop

	fstp st0
	fstp st0

	mov eax, [ebp+8]
	add eax, 8
	fstp dword[eax]
	
	add eax, 4
	mov ecx, [ebp-8]
	mov [eax], ecx

	add eax, 4
	fld dword[ebp-12]
	fstp dword[eax]
	
epi:	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
