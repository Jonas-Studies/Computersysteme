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
	TESTSTRING_DIVISION_RESULT:
		.asciz "%ld R %ld\n"
	TESTSTRING_MULTIPLICATION_RESULT:
		.asciz "%ld\n"

.section .bss
	.lcomm x, 8
	.lcomm y, 8

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	movq C61, %rax
	cdq

	idivq C5
	
	movq %rax, x
	movq %rdx, y
	
	movq $TESTSTRING_DIVISION_RESULT, %rdi
	movq %rax, %rsi
	# Der Rest steht automatisch in %rdx
	call printf

	movq x, %rax

	imulq C7

	movq %rax, x

	movq $TESTSTRING_MULTIPLICATION_RESULT, %rdi
	movq %rax, %rsi
	call printf

	movq x, %rax
	cdq

	idivq CNEG17

	movq %rax, x
	addq %rdx, y

	movq $TESTSTRING_DIVISION_RESULT, %rdi
	movq %rax, %rsi
	# Der Rest steht automatisch in %rdx
	call printf

	movq $OUTSTRING, %rdi
	movq x, %rsi
	movq y, %rdx
	call printf

	movq $0, %rax
	popq %rbp

	ret
