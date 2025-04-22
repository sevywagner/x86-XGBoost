	section .data
n_one:	dd	-1
one:	dd	1.0

	section .text
	global get_value

	extern sum
get_value:
	push ebp
	mov ebp, esp

	push dword[ebp+8]
	call sum
	add esp, 4

	fild dword[n_one]
	fmulp

	push dword[ebp+12]
	call sum
	add esp, 4

	fld dword[one]
	faddp

	fdivp st1, st0
	
	pop ebp
	ret
