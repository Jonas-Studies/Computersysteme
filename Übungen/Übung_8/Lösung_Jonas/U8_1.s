.section .rodata
	array:
		.quad 1004
		.quad 999
		.quad 729
		.quad -33
		.quad 1002
		.quad 1006
		.quad 2000
		

.section .text
	.globl _start
	.type _start, @function

_start:
  pushq %rbp
  movq %rsp, %rbp

  // For-loop
  movq $0, %r15
  jmp while_r15_isNotGreater_6
while_r15_isNotGreater_6_do:
  leaq array, %r14
  movq (%r14, %r15, 8), %r13

  cmp $999, %r13
  je case_is_999

  cmp $1002, %r13
  je case_is_1002

  cmp $1004, %r13
  je case_is_1004

  cmp $1006, %r13
  je case_is_1006

  jmp case_default

case_default:
  movq $0, %rdi
  jmp case_end

case_is_999:
  movq $1, %rdi
  jmp case_end

case_is_1002:
  movq $2, %rdi
  jmp case_end

case_is_1004:
case_is_1006:
  movq $3, %rdi
  jmp case_end

case_end:
  addq $1, %r15

while_r15_isNotGreater_6:
  cmp $6, %r15
  jle while_r15_isNotGreater_6_do

  movq $60, %rax
  movq $0, %rdi
  popq %rbp
  syscall
