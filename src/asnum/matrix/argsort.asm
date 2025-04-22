	section .text
	global argsort

	extern seperate_matrix
	extern generate_arange_idx_mask
	extern copy_array
	extern free_array
argsort:
	push ebp
	mov ebp, esp
	sub esp, 28
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	add edx, 4
	mov ebx, [edx]

	push 4
	push dword[edx]
	push eax
	call copy_array
	add esp, 12

	mov edi, ebx
	mov ebx, eax

	push edi
	call generate_arange_idx_mask
	add esp, 4

	mov [ebp-4], eax

	add eax, 8
	mov eax, [eax]

	mov [ebp-24], edi

	;; eax = res->array
	;; ebx = m->array
	;; ecx = array len
	;; ebp - 4 = *res

	xor esi, esi
i_loop:
	xor edi, edi
	
j_loop:
	mov edx, esi
	shl edx, 2
	mov [ebp-8], edx
	add edx, ebx
	fld dword[edx]

	mov edx, [ebp-8]
	add edx, eax
	mov ecx, [edx]
	mov [ebp-16], ecx

	mov edx, edi
	shl edx, 2
	mov [ebp-12], edx
	add edx, ebx
	fld dword[edx]

	mov edx, [ebp-12]
	add edx, eax
	mov ecx, [edx]
	mov [ebp-20], ecx
	
	fcomi st0, st1
	jbe pop_fpu_stack

	mov edx, [ebp-8]
	add edx, ebx
	fstp dword[edx]

	mov edx, [ebp-12]
	add edx, ebx
	fstp dword[edx]

	mov ecx, [ebp-20]
	mov edx, [ebp-8]
	add edx, eax
	mov dword[edx], ecx

	mov ecx, [ebp-16]
	mov edx, [ebp-12]
	add edx, eax
	mov dword[edx], ecx

	jmp increment

pop_fpu_stack:
	fstp
	fstp
	
increment:
	inc edi
	cmp edi, [ebp-24]
	jl j_loop

	inc esi
	cmp esi, [ebp-24]
	jl i_loop

	push ebx
	call free_array
	add esp, 4

	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
