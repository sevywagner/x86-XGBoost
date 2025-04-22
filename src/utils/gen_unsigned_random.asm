	section .text
	global gen_unsigned_random

gen_unsigned_random:
	push ebp
	mov ebp, esp
	push ebx

	rdtsc
	xor edx, edx
	and eax, 0xFF

	mov ebx, [ebp+12]
	sub ebx, [ebp+8]
	div ebx
	
	mov eax, edx
	add eax, [ebp+8]
	xor edx, edx
	
	pop ebx
	pop ebp
	ret
