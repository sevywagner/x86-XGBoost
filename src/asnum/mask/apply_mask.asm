	section .text
	global apply_mask

	extern seperate_matrix
	extern matrix_init
	extern free_matrix
	extern transpose

apply_mask:
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

	cmp dword[edx], 1
	jne reg_dims

	push dword[ebp+8]
	call transpose
	add esp, 4

	mov dword[ebp-8], 1
	mov [ebp-12], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov ebx, eax
	
reg_dims:
	mov esi, [edx]
	
	mov eax, [ebp+12]
	add eax, 4
	add edx, 4

	mov ecx, [edx]
	shl ecx, 2
	mov [ebp-16], ecx
	
	push dword[edx]
	push dword[eax]
	call matrix_init
	add esp, 8

	mov [ebp-4], eax

	push eax
	call seperate_matrix
	add esp, 4

	mov ecx, esi

	mov edx, [ebp+12]
	add edx, 8
	mov edx, [edx]

	;; eax = res->array
	;; ebx = m->array
	;; ecx = length
	;; edx = mask->array
	;; ebp - 16 = cols length (bytes)

	mov esi, [ebp+12]
	cmp dword[esi], 1
	jne idx_type
	
	xor esi, esi
bin_loop:
	cmp dword[edx], 1
	jne skip_row

	xor edi, edi
copy_loop:
	fld dword[ebx]
	fstp dword[eax]

	add ebx, 4
	add eax, 4
	add edi, 4
	cmp edi, [ebp-16]
	jl copy_loop
	jmp increment
	
skip_row:
	add ebx, [ebp-16]
	
increment:
	add edx, 4
	inc esi
	cmp esi, ecx
	jl bin_loop

	jmp done
	
		
idx_type:
	xor esi, esi

idx_loop:
	mov edi, [edx]
	shl edi, 2
	add edi, ebx
	fld dword[edi]
	fstp dword[eax]
	
	add edx, 4
	add eax, 4

	inc esi
	cmp esi, ecx
	jl idx_loop

done:
	cmp dword[ebp-8], 1
	jne epi

	push dword[ebp-12]
	call free_matrix
	add esp, 4
	
epi:
	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
