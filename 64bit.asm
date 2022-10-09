
segment .data

	fmt_scanf	db 	"%d",0
	fmt_printf	db	"%d",10,0
	largest		db	"Largest: ",0
	smallest	db	"Smallest: ",0
	sum			db	"Sum: ",0

segment .bss

	arr		resd	10

segment .text
	global  main
	extern	scanf
	extern 	printf

main:
	push	rbp
	mov		rbp, rsp
	; ********** CODE STARTS HERE **********

	; read 10 ints
	mov		r15, 0
	top_read_loop:
		cmp		r15, 10
		jge		end_read_loop

		mov		rdi, fmt_scanf
		lea		rsi, [arr + r15 * 4]
		call	scanf

		inc		r15
		jmp		top_read_loop
	end_read_loop:


	; sort
	mov		r10, 0
	top_loop1:
		cmp		r10, 10
		jge		end_loop1

		mov		r11, 0
		top_loop2:
			cmp		r11, 10
			jge		end_loop2

			mov		r12d, DWORD [arr + r10 * 4]
			mov		r13d, DWORD [arr + r11 * 4]
			cmp		r12d, r13d
			jle		no_swap
				xchg	r12d, r13d
				mov		DWORD [arr + r10 * 4], r12d
				mov		DWORD [arr + r11 * 4], r13d
			no_swap:

			inc		r11
			jmp		top_loop2
		end_loop2:

		inc		r10
		jmp		top_loop1
	end_loop1:

	; print
	mov		r15, 0

	mov		r14d, 0 			; to calculate sum
	top_print_loop:
		cmp		r15, 10
		jge		print_sum
		mov		esi, DWORD [arr + r15 * 4]
		mov		r13d, esi
		add		r14d, esi
		cmp		r15, 0
		je		print_largest
		cmp		r15, 9
		je		print_smallest
		return:
		add		r15, 1
		jmp		top_print_loop

		print_largest:
			mov		rdi, largest
			call 	printf
			mov		rdi, fmt_printf
			mov		esi, r13d
			call	printf
			jmp		return
		print_smallest:
			mov		rdi, smallest
			call	printf
			mov		rdi, fmt_printf
			mov		esi, r13d
			call	printf
			jmp		return
		print_sum:
			mov		rdi, sum
			call	printf
			mov		rdi, fmt_printf
			mov		esi, r14d
			call	printf
			jmp		end_print_loop
	end_print_loop:









	; *********** CODE ENDS HERE ***********
	mov		rax, 0
	mov		rsp, rbp
	pop		rbp
	ret
