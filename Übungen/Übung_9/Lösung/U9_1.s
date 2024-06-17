.section .data
	# Array 3 x 4
	aSh:
		.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	// Adresse des arrays in %rdi
	leaq aSh, %rdi

	// Laden von i = 1 in %rsi
	movq $1, %rsi
	// Laden von j = 0 in %rdx
	movq $0, %rdx
	// Schreibt den wert des arrays der Stelle i * 4 + j nach %cx
	call get_value_by_position

	// Da der Funktionsaufruf immer %ax überschreibt kommt das Ergebnis in %rax
	movzwq %cx, %rax
	
	// Laden von i = 2 in %rsi
	movq $2, %rsi
	// Laden von j = 3 in %rdx
	movq $3, %rdx
	// Schreibt den wert des arrays der Stelle i * 4 + j nach %cx
	call get_value_by_position

	// Adderen von cx auf das Ergebnis
	addw %cx, %ax

	movq $0, %rax
	popq %rbp
	ret

// Returns the arrays value from i * 4 + j
// Result in %cx, i in %rsi, j in %rdx
get_value_by_position:
	leaq (, %rsi, 4), %rcx
	leaq (%rdi, %rcx, 2), %rcx
	// Ergebnis als quad zum debuggen, sonst cx
	movzwq (%rcx, %rdx, 2), %rcx

	ret
