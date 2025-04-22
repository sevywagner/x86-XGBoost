	section .text
	global sort

	extern seperate_matrix

sort:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push esi
	push edi

	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov ecx, [edx]
	add edx, 4
	imul ecx, [edx]		; ecx = len
	
	mov ebx, eax

	xor esi, esi
i_loop:
	xor edi, edi
j_loop:
	mov eax, esi
	shl eax, 2
	add eax, ebx
	fld dword[eax]		; st(0) = arr[i]

	mov edx, edi
	shl edx, 2
	add edx, ebx
	fld dword[edx]		; st(0) = arr[j] st(1) = arr[i]

	fcomi st0, st1
	jbe pop_fpu_stack

	fstp dword[eax]
	fstp dword[edx]
	jmp increment

pop_fpu_stack:
	fstp
	fstp

increment:
	inc edi
	cmp edi, ecx
	jl j_loop

	inc esi
	cmp esi, ecx
	jl i_loop
	
	pop edi
	pop esi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
