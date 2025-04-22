	section .data
one:	dd	1

	align 4
OpTable:	
	dd	greater_than, greater_than_equal_to
	dd	less_than, less_than_equal_to
	dd	equal_to, not_equal_to

OpTableLen: equ ($-OpTable)

	section .text
	global generate_mask

	extern seperate_matrix
	extern mask_init
generate_mask:
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
	add edx, 4
	mov edi, [edx]

	push dword[edx]
	call mask_init
	add esp, 4

	mov ecx, edi
	mov dword[ebp-8], 0
	mov [ebp-4], eax

	mov edx, eax
	add edx, 8
	mov eax, [edx]

	fld dword[ebp+20]

	mov edi, [ebp+12]
	shl edi, 2
	add edi, OpTable

	;; eax = mask res->array
	;; ebp - 4 = *res
	;; ebx = m->array
	;; ecx = res length
	;; ebp - 8 = num ones

	xor esi, esi
i_loop:
	fld dword[ebx]

	fcomip st0, st1
	jmp [edi]

greater_than:
	ja set_one
	jmp set_zero
	
greater_than_equal_to:
	jae set_one
	jmp set_zero
	
less_than:
	jb set_one
	jmp set_zero
	
less_than_equal_to:
	jbe set_one
	jmp set_zero
	
equal_to:
	je set_one
	jmp set_zero

not_equal_to:
	jne set_one
	jmp set_zero
	
set_one:
	inc dword[ebp-8]
	mov dword[eax], 1
	jmp increment

set_zero:
	mov dword[eax], 0

increment:	
	add ebx, 4
	add eax, 4

	inc esi
	cmp esi, ecx
	jl i_loop

done:
	mov edx, [ebp-4]
	mov esi, [ebp+16]
	mov dword[edx], esi
	mov esi, [ebp-8]
	add edx, 4
	mov dword[edx], esi
	mov eax, [ebp-4]

	fstp st0

	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
