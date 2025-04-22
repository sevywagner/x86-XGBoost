	section .data
half:	dd	0.5
	
	section .text
	global get_gain

	extern REG_LAMBDA
get_gain:
	push ebp
	mov ebp, esp

	fld dword[ebp+24]
	fld st0
	fmulp
	fld dword[ebp+28]
	fld dword[REG_LAMBDA]
	faddp
	fdivp

	fld dword[ebp+8]
	fld st0
	fmulp
	fld dword[ebp+12]
	fld dword[REG_LAMBDA]
	faddp
	fdivp

	fsubp

	fld dword[ebp+16]
	fld st0
	fmulp
	fld dword[ebp+20]
	fld dword[REG_LAMBDA]
	faddp
	fdivp

	faddp

	fld dword[half]
	fmulp
	
	pop ebp
	ret
