.section .data

outstring:
.asciz "Vorname: Jonas, Nachname: Zengerle, MatNr: 3424791"

.section .text
.globl main
.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	movq $outstring, %rdi
	call puts

	movq $0, %rax
	popq %rbp

	ret
