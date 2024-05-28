.section .rodata
	OUTPUT_DECIMAL:
		.asciz "%ld"
	OUTPUT_SPACE:
		.asciz " "
	OUTPUT_BLANKS:
		.asciz ""

.section .text
	.globl main
	.type main, @function

	.equ LIMIT, 3

main:
	pushq %rbp
	movq %rsp, %rbp

	movq $1, %r14

do_while_r14_isNotGreater_LIMIT:
	movq $1, %r12

	jmp while_r12_isNotGreater_LIMIT

do_for_r12_isNotGreater_LIMIT:
	movq $1, %r13

	jmp while_r13_isNotGreater_LIMIT

while_r13_isNotGreater_LIMIT_do:
	movq $OUTPUT_DECIMAL, %rdi
	movq %r13, %rsi
	call printf

	add $1, %r13

while_r13_isNotGreater_LIMIT:
	cmp $LIMIT, %r13
	jbe while_r13_isNotGreater_LIMIT_do

	movq $OUTPUT_SPACE, %rdi
	call printf

	addq $1, %r12
	
while_r12_isNotGreater_LIMIT:
	cmp $LIMIT, %r12
	jbe do_for_r12_isNotGreater_LIMIT

	addq $1, %r14

	movq $OUTPUT_BLANKS, %rdi
	call puts

	cmp $LIMIT, %r14
	jbe do_while_r14_isNotGreater_LIMIT

	movq $0, %rax
	popq %rbp

	ret
