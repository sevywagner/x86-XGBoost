	section .text
	global copy_array

	extern array_init
copy_array:
	push ebp
	mov ebp, esp
	sub esp, 8
	push ebx
	push edi
	push esi

	push dword[ebp+16]
	push dword[ebp+12]
	call array_init
	add esp, 8

	mov [ebp-4], eax

	mov ecx, [ebp+12]
	mov edi, [ebp+16]
	mov [ebp-8], edi

	mov ebx, [ebp+8]

	;; eax = res
	;; ebx = src
	;; ecx = len
	;; ebp - 8 = var size
	
	xor esi, esi
i_loop:
	xor edi, edi
	xor edx, edx
move_byte:
	mov dl, byte[ebx]
	mov byte[eax], dl
	inc ebx
	inc eax
	inc edi
	cmp edi, [ebp-8]
	jl move_byte
	
	inc esi
	cmp esi, ecx
	jl i_loop

	mov eax, [ebp-4]
	
	pop esi
	pop esi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
