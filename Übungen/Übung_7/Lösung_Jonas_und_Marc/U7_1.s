.section .rodata
	OUTPUT_DECIMAL:
		.asciz "%c"
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

	movb $1, %r14b

do_while_r14_isNotGreater_LIMIT:
	movb $1, %r12b

	jmp while_r12_isNotGreater_LIMIT

do_for_r12_isNotGreater_LIMIT:
	movb $1, %r13b

	jmp while_r13_isNotGreater_LIMIT

while_r13_isNotGreater_LIMIT_do:
	movq $OUTPUT_DECIMAL, %rdi
	movb %r13b, %sil
	addb $48, %sil
	call printf

	addb $1, %r13b

while_r13_isNotGreater_LIMIT:
	cmp $LIMIT, %r13b
	jbe while_r13_isNotGreater_LIMIT_do

	movq $OUTPUT_SPACE, %rdi
	call printf

	addb $1, %r12b
	
while_r12_isNotGreater_LIMIT:
	cmp $LIMIT, %r12b
	jbe do_for_r12_isNotGreater_LIMIT

	addb $1, %r14b

	movq $OUTPUT_BLANKS, %rdi
	call puts

	cmp $LIMIT, %r14b
	jbe do_while_r14_isNotGreater_LIMIT

	movq $0, %rax
	popq %rbp

	ret
