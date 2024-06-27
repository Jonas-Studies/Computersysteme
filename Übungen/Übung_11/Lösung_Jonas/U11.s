.section .rodata
	OUTPUT_CHARACTER:
		.asciz "%c"
	OUTPUT_BLANKS:
		.asciz ""
	WORD:
		.asciz "ABC"
	
.section .text
	.global main
		.type main, @function
	.global print_reverse_start
		.type print_reverse_start, @function
	
main:
	pushq %rbp
	movq %rsp, %rbp

	leaq WORD, %rdi
	movl $3, %esi

	call print_reverse_start

	movq $OUTPUT_BLANKS, %rdi
	call puts
	
	movq %rbp, %rsp
	popq %rbp
	movq $0, %rax

	ret

print_reverse_start:
	pushq %rbp
	movq %rsp, %rbp

	cmp $0, %rsi
	je print_reverse_end

	subq $1, %rsi

	pushq %rdi
	pushq %rsi

	movzbq (%rsi, %rdi), %rsi
	movq $OUTPUT_CHARACTER, %rdi
	movq $0, %rax
	call printf

	popq %rsi
	popq %rdi

	call print_reverse_start

print_reverse_end:
	movq %rbp, %rsp
	popq %rbp
	movq $0, %rax

	ret
