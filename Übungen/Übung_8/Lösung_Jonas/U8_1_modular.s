.section .rodata
	array:
		.quad 1004
		.quad 999
		.quad 729
		.quad -33
		.quad 1002
		.quad 1006
		.quad 2000
	
	jumptable:
		.quad case_is_999
		.quad case_default
		.quad case_default
		.quad case_is_1002
		.quad case_default
		.quad case_is_1004
		.quad case_default
		.quad case_is_1006
	
.section .text
	.globl _start
	.type _start, @function

_start:
  pushq %rbp
  movq %rsp, %rbp

  jmp for_loop_start

end:
  movq $60, %rax
  movq $0, %rdi
  popq %rbp
  syscall


for_loop_start:
  movq $0, %r15

for_loop_condition:
  // loop from 0 to 5
  cmp $6, %r15
  jg for_loop_end

  jmp case_start

for_loop_statement:
  addq $1, %r15
  jmp for_loop_condition

for_loop_end:
  jmp end


case_start:
  // Compare the value at the for loop-values position in the array
  movq array(, %r15, 8), %r14
  
  cmp $999, %r14
  jl case_default

  cmp $1006, %r14
  jg case_default

  subq $999, %r14
  jmp *jumptable(, %r14, 8)

case_default:
  movq $0, %rax
  jmp case_end

case_is_999:
  movq $1, %rax
  jmp case_end

case_is_1002:
  movq $2, %rax
  jmp case_end

case_is_1004:
case_is_1006:
  movq $3, %rax
  jmp case_end

case_end:
  jmp for_loop_statement
