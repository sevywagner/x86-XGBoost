	section .text
	global fit_tree

	extern tree_booster_init
	extern find_best_split
	extern sum
	extern get_column
	extern generate_mask
	extern apply_mask
	extern free_matrix
	extern free_mask
	extern get_value
	extern seperate_matrix

	extern MAX_DEPTH
	extern MIN_SAMPLES
fit_tree:
	push ebp
	mov ebp, esp
	sub esp, 44
	push ebx
	push edi
	push esi

	call tree_booster_init

	mov [ebp-4], eax

	push dword[ebp+16]
	push dword[ebp+12]
	call get_value
	add esp, 8

	mov eax, [ebp-4]
	add eax, 20
	fstp dword[eax]
	
	mov edx, [ebp+20]
	cmp edx, [MAX_DEPTH]
	jl depth_in_range

	sub eax, 12
	mov dword[eax], 0
	jmp done

depth_in_range:
	push dword[ebp+8]
	call seperate_matrix
	add esp, 4

	mov edx, [edx]
	cmp edx, [MIN_SAMPLES]
	jge sample_count_in_range

	mov eax, [ebp-4]
	add eax, 8
	mov dword[eax], 0
	jmp done

sample_count_in_range:	
	push dword[ebp+16]
	push dword[ebp+12]
	push dword[ebp+8]
	push dword[ebp-4]
	call find_best_split
	add esp, 16

	mov eax, [ebp-4]
	add eax, 8
	fldz
	fld dword[eax]

	fcomip st0, st1
	jne best_gain_not_zero

	jmp done

best_gain_not_zero:
	mov eax, [ebp-4]
	add eax, 16
	fld dword[eax]
	fstp dword[ebp-8]
	
	sub eax, 4
	push dword[eax]
	push dword[ebp+8]
	call get_column
	add esp, 8

	mov [ebp-12], eax
	mov edi, eax

	push dword[ebp-8]
	push 1
	push 3
	push edi
	call generate_mask
	add esp, 16

	mov [ebp-16], eax

	push dword[ebp-8]
	push 1
	push 0
	push edi
	call generate_mask
	add esp, 16

	mov [ebp-20], eax

	mov esi, [ebp-16]
	mov edi, [ebp-20]

	;; ebp-12 = col
	;; ebp-16 = lm
	;; ebp-20 = rm
	
	;; esi = lm
	;; edi = rm

	push esi
	push dword[ebp+8]
	call apply_mask
	add esp, 8

	mov [ebp-24], eax

	push edi
	push dword[ebp+8]
	call apply_mask
	add esp, 8

	mov [ebp-28], eax

	push esi
	push dword[ebp+12]
	call apply_mask
	add esp, 8

	mov [ebp-32], eax

	push edi
	push dword[ebp+12]
	call apply_mask
	add esp, 8
	
	mov [ebp-36], eax

	push esi
	push dword[ebp+16]
	call apply_mask
	add esp, 8
	
	mov [ebp-40], eax

	push edi
	push dword[ebp+16]
	call apply_mask
	add esp, 8
	
	mov [ebp-44], eax

	;; ebp-24 = xl
	;; ebp-28 = xr
	;; ebp-32 = gl
	;; ebp-36 = gr
	;; ebp-40 = hl
	;; ebp-44 = hr

	mov edi, [ebp+20]
	inc edi

	push edi
	push dword[ebp-40]
	push dword[ebp-32]
	push dword[ebp-24]
	call fit_tree
	add esp, 16

	mov edx, [ebp-4]
	mov [edx], eax

	push edi
	push dword[ebp-44]
	push dword[ebp-36]
	push dword[ebp-28]
	call fit_tree
	add esp, 16

	mov edx, [ebp-4]
	add edx, 4
	mov [edx], eax

done:
	mov eax, [ebp-4]
	
	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
