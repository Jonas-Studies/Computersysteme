.section .data
outstring:
	.asciz "Hex: %#lx, Dec: %ld\n"

.section .text
	.globl main
	.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	# Write 888.888.888.888 in %rax
	movq $888888888888, %rax

	# Write 777.777 in %eax
	# Problem: movl and shll on %eax overwrite all of %rax
	# Soluiton:
	# Shift %rax to the right with just enough space left for a word
	shrq $16, %rax
	# Place 777.777 in another register
	movl $777777, %ebx
	# Shift the other register to the right so that its word is 00 0B
	shrl $16, %ebx
	# Place that word in %rax
	movw %bx, %ax
	# Shift %rax to the left so that enough free space for another word is created
	shlq $16, %rax
	# Place 777.777 in the other register again
	movl $777777, %ebx
	# Move the other registers word in %rax
	movw %bx, %ax

	# Write 30 in %al
	movb $30, %al

	# Write 31 in %ah
	movb $31, %ah

	# Display %rax in Hex and Dec with printf
	movq $outstring, %rdi
	movq %rax, %rdx
	movq %rax, %rsi
	movq $0, %rax
	call printf

	movq $0, %rax
	popq %rbp

	ret
