.section .rodata

.section .bss

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	movq $0, %rax
	popq %rbp

	ret
