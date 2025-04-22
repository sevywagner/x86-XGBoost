	section .data
one:	dd	1

	section .text
	global sum

	extern seperate_matrix
sum:
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	add edx, 4
	imul ecx, [edx]

	fldz
	xor esi, esi
i_loop:
	fld dword[eax]
	faddp

	add eax, 4
	inc esi
	cmp esi, ecx
	jl i_loop
	
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
