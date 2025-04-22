	section .text
	global get_row

	extern seperate_matrix
	extern matrix_init
get_row:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ebx, eax

	add edx, 4
	mov edi, [edx]
	push dword[edx]
	push 1
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	;; eax = res->array
	;; ebx = m->array
	;; edi = cols

	mov edx, [ebp+12]
	imul edx, edi
	shl edx, 2
	add edx, ebx
	
	xor esi, esi
i_loop:
	fld dword[edx]
	fstp dword[eax]

	add edx, 4
	add eax, 4

	inc esi
	cmp esi, edi
	jl i_loop

	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
