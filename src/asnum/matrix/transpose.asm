	section .text
	global transpose

	extern matrix_init
	extern seperate_matrix
transpose:
	push ebp
	mov ebp, esp
	sub esp, 20
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ebx, eax

	mov ecx, [edx]
	mov [ebp-8], ecx
	shl ecx, 2
	mov [ebp-12], ecx
	add edx, 4
	mov ecx, [edx]
	mov [ebp-16], ecx
	shl ecx, 2
	mov [ebp-20], ecx

	sub edx, 4

	push dword[edx]
	add edx, 4
	push dword[edx]
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	;; eax = res->array
	;; ebx = m->array
	;; ebp - 8 = m->rows
	;; ebp - 12 = m->rows(bytes)
	;; ebp - 16 = m->cols
	;; ebp - 20 = m->cols(bytes)

	xor esi, esi
i_loop:
	mov edx, esi
	imul edx, [ebp-20]
	add edx, ebx

	mov ecx, esi
	shl ecx, 2
	add ecx, eax

	xor edi, edi
copy_loop:
	fld dword[edx]
	fstp dword[ecx]

	add ecx, [ebp-12]
	add edx, 4

	inc edi
	cmp edi, [ebp-16]
	jl copy_loop

	inc esi
	cmp esi, [ebp-8]
	jl i_loop

	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
