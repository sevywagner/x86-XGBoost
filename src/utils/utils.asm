	section .text
	global seperate_matrix

	;; 
	;; seperate matrix into its dims and array
	;; params:
	;;	matrix
	;; 
seperate_matrix:
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov edx, [ebx]
	add ebx, 4
	mov eax, [ebx]
	
	pop ebx
	pop ebp
	ret
