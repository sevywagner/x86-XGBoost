	section .text
	global generate_arange_idx_mask

	extern mask_init
generate_arange_idx_mask:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call mask_init
	add esp, 4

	mov [ebp-4], eax
	mov dword[eax], 0
	add eax, 4
	mov ecx, [ebp+8]
	mov dword[eax], ecx
	add eax, 4
	mov eax, dword[eax]

	mov ecx, [ebp+8]

	xor esi, esi
i_loop:
	mov dword[eax], esi
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
