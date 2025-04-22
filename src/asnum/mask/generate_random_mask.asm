	section .text
	global generate_random_mask

	extern gen_unsigned_random
	extern mask_init

generate_random_mask:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push edi
	push esi

	push dword[ebp+20]
	call mask_init
	add esp, 4

	mov [ebp-4], eax

	mov dword[eax], 1
	add eax, 4
	mov edi, [ebp+8]
	mov [eax], edi
	add eax, 4
	mov ebx, [eax]

	xor esi, esi
i_loop:
	push dword[ebp+16]
	push dword[ebp+12]
	call gen_unsigned_random
	add esp, 8

	shl eax, 2
	add eax, ebx

	cmp dword[eax], 1
	je i_loop

	mov dword[eax], 1
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
