	section .text
	global get_column

	extern seperate_matrix
	extern matrix_init
get_column:
	push ebp
	mov ebp, esp
	sub esp, 8
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ebx, eax

	push dword[edx]
	push 1
	add edx, 4
	mov edi, [edx]
	call matrix_init
	add esp, 8

	mov esi, eax

	push eax
	call seperate_matrix
	add esp, 4

	mov [ebp-4], esi
	add edx, 4
	mov ecx, [edx]

	mov edx, [ebp+12]
	mov [ebp-8], edx

	;; eax = res->array
	;; ebx = m->array
	;; ecx = len
	;; edi = m->dims[1] (cols)
	;; ebp - 8 = col

	xor esi, esi
i_loop:
	mov edx, esi
	imul edx, edi
	add edx, [ebp-8]
	shl edx, 2
	add edx, ebx

	fld dword[edx]
	fstp dword[eax]

	add eax, 4
	inc esi
	cmp esi, ecx
	jl i_loop

	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
