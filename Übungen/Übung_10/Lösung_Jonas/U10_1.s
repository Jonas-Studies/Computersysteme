.section .rodata
	OUTPUT:
		.asciz "Result: %ld\n"

.section .text
	.globl main
		.type main, @function
	.globl calculate_sum_and_multiply
		.type calculate_sum_and_multiply, @function
	.globl multiply
		.type multiply, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	movq $1, %rdi
	movq $2, %rsi
	movq $3, %rdx
	movq $4, %rcx
	movq $5, %r8
	movq $6, %r9

	movq $7, %r13
	movq $8, %r14
	// Definieren von sum auf dem stack
	pushq $0
	movq %rsp, %r15

	pushq %rdi
	pushq %rsi

	pushq %r15
	pushq %r14
	pushq %r13
	
	call calculate_sum_and_multiply

	popq %r13
	popq %r14
	popq %r15

	popq %rsi
	popq %rdi

	addq %rdi, %rsi
	addq %rax, %rsi
	movq $0, %rax
	movq $OUTPUT, %rdi
	call printf

	popq %r15

	movq $0, %rax
	popq %rbp
	ret

calculate_sum_and_multiply:
	movq 8(%rsp), %r13
	movq 16(%rsp), %r14
	movq 24(%rsp), %r15

	movq %rdi, (%r15)
	addq %rsi, (%r15)
	addq %rdx, (%r15)
	addq %rcx, (%r15)
	addq %r8, (%r15)
	addq %r9, (%r15)
	addq %r13, (%r15)
	addq %r14, (%r15)

	movq $2, %rdi
	movq $3, %rsi
	movq (%r15), %rdx

	call multiply

	ret

multiply:
	movq %rdx, %rax
	
	cqto
	imulq %rdi
	imulq %rsi

	ret
