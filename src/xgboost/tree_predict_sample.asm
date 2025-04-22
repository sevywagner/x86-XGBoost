	section .text
	global tree_predict_sample

	extern seperate_matrix
tree_predict_sample:
	push ebp
	mov ebp, esp
	push ebx

	push dword[ebp+12]
	call seperate_matrix
	add esp, 4

	mov ebx, eax

	mov eax, [ebp+8]

	;; eax = tb
	;; ebx = sample->array

trav_loop:
	fld dword[edx]
	mov edx, eax
	add edx, 8
	fld dword[edx]
	fldz

	fcomi st0, st1
	fstp st0
	fstp st0
	je done
	
	mov edx, eax
	add edx, 12
	mov edx, [edx]
	shl edx, 2
	add edx, ebx
	fld dword[edx]

	mov edx, eax
	add edx, 16
	fld dword[edx]

	fcomi st0, st1
	fstp st0
	fstp st0
	jb right

	mov eax, [eax]
	jmp loop_back
right:
	add eax, 4
	mov eax, [eax]

loop_back:
	fstp st0
	jmp trav_loop
	
done:
	fstp st0
	mov edx, eax
	add edx, 20
	fld dword[edx]
	
	pop ebx
	pop ebp
	ret
