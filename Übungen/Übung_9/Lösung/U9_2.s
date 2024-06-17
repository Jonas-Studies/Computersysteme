.section .data
	struct_01:
		.byte 0
		.long 1
		.quad 0
	
	.globl struct_02
	.type struct_03, @object
	.size struct_02, 24
	.align 8
	struct_02:
		.byte 0
		.zero 7
		.long 2
		.zero 4
		.quad 0

	.globl struct_03
	.type struct_03, @object
	.size struct_03, 24
	.align 8
	struct_03:
		.quad 0
		.long 3
		.zero 4
		.byte 0

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	// Aufgabenstellung sagt nix wie n initialisiert werden soll, hab mal 1, 2, 3 genommen

	// Initialisieren struct_01 (Verschieben von *n nach pN)
	leaq struct_01, %r15
	leaq 1(%r15), %r14
	movq %r14, 5(%r15)

	// Initialisieren struct_02 (Verschieben von *n nach pN)
	leaq struct_02, %r14
	leaq 8(%r14), %r13
	movq %r13, 16(%r14)

	// Initialisieren struct_03 (Verschieben von *n nach pN)
	leaq struct_03, %r13
	leaq 8(%r13), %r12
	movq %r12, (%r13)

	// Laden des longs von struct 01, über die Adresse im quad, nach eax
	movq 5(%r15), %r12
	movl (%r12), %eax
	
	// Addieren des longs von struct 02, über die Adresse im quad, auf eax
	movq 16(%r14), %r12
	add (%r12), %eax
	
	// Addieren des longs von struct 03, über die Adresse im quad, auf eax
	movq (%r13), %r12
	add (%r12), %eax
	
	movq $0, %rax
	popq %rbp
	ret
