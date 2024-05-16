.section .rodata
	C61:
		.quad 61
	C5:
		.quad 5
	C7:
		.quad 7
	CNEG17:
		.quad -17
	OUTSTRING:
		.asciz "x: %ld, y: %ld\n"

.section .bss
	.lcomm x, 8
	.lcomm y, 8

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	// Teilen von 61 durch 5
	movq C61, %rax
	cdq
	idivq C5
	
	movq %rdx, y

	// Multiplizieren von rax mit 7
	imulq C7

	// Teilen von rax durch -17
	cdq
	idivq CNEG17

	movq %rax, x
	addq %rdx, y

	movq $OUTSTRING, %rdi
	movq x, %rsi
	movq y, %rdx
	call printf

	movq $0, %rax
	popq %rbp

	ret
