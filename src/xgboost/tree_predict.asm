	section .text
	global tree_predict

	extern seperate_matrix
	extern array_init
	extern tree_predict_sample
	extern free_matrix
	extern get_row
tree_predict:
	push ebp
	mov ebp, esp
	sub esp, 8
	push ebx
	push edi
	push esi

	push dword[ebp+12]
	call seperate_matrix
	add esp, 4

	mov edi, [edx]

	push 4
	push dword[edx]
	call array_init
	add esp, 8

	mov [ebp-4], eax
	mov ebx, eax

	xor esi, esi
i_loop:
	push esi
	push dword[ebp+12]
	call get_row
	add esp, 8

	mov [ebp-8], eax

	push eax
	push dword[ebp+8]
	call tree_predict_sample
	add esp, 8

	fstp dword[ebx]

	push dword[ebp-8]
	call free_matrix
	add esp, 4
	
	add eax, 4
	add ebx, 4
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
