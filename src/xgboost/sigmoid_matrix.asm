	section .text
	global sigmoid_matrix

	extern array_init
	extern matrix_init
	extern seperate_matrix
	extern sigmoid
	extern free_array
sigmoid_matrix:
	push ebp
	mov ebp, esp
	sub esp, 12
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov [ebp-8], eax

	push dword[edx]
	add edx, 4
	push dword[edx]
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov edi, [edx]
	mov [ebp-12], eax

	mov ebx, [ebp-8]

	;; ebp-4 = *res
	;; ebp-8 = m->array
	;; ebp-12 = res->array

	xor esi, esi
i_loop:
	mov edx, [ebp-8]
	push dword[edx]
	call sigmoid
	add esp, 4

	mov edx, [ebp-12]
	fstp dword[edx]

	add dword[ebp-8], 4
	add dword[ebp-12], 4

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
