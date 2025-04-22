	section .data
one:	dd	1

	section .text
	global e_exp

e_exp:
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	push edi
	push esi
	
	fld dword[ebp+8]
	fild dword[one]
	faddp

	mov esi, 2
i_loop:
	fld dword[ebp+8]	;st0 = exp st1 = res
	mov edi, esi
	dec edi		
exp_loop:	
	fld dword[ebp+8]	; st0 = exp st1 = exp st2 = res
	fmulp			; st0 = exp * exp st1 = res

	dec edi
	cmp edi, 0
	jg exp_loop

	mov [ebp-4], esi
	fild dword[ebp-4]	; st0 = j st1 = exp st2 = res
	dec dword[ebp-4]
fact_loop:
	fild dword[ebp-4]	; st0 = j - 1 st1 = j st2 = exp st3 = res
	fmulp			; st0 = j * j - 1 st1 = exp st2 = res

	dec dword[ebp-4]
	cmp dword[ebp-4], 0
	jg fact_loop
	;; st0 = factorial st1 = exponent st2 = res
	fdivp st1, st0
	faddp			; st0 = res

	inc esi
	cmp esi, 40
	jl i_loop
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
