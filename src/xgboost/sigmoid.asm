	section .data
one:	dd	1
n_one:	dd	-1

	section .text
	global sigmoid

	extern matrix_init
	extern seperate_matrix
	extern e_exp
sigmoid:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push edi
	push esi

	fild dword[one]

	fld dword[ebp+8]
	fild dword[n_one]
	fmulp
	fstp dword[ebp-4]

	push dword[ebp-4]
	call e_exp
	add esp, 4

	fild dword[one]
	faddp
	fdivp
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
