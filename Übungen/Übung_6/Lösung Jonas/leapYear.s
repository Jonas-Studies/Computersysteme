.section .bss
	.lcomm yearText, 5
	.lcomm year, 2
	.lcomm isLeapyear, 1

.section .rodata
	promptText:
		.ascii "Enter a year >= 1700 && year <= 9999: "
	outputSuccess:
		.asciz "leap year\n"
	outputFailure:
		.asciz "no leap year\n"

.section .text
.globl _start
.type _start, @function

_start:
  pushq %rbp
  movq %rsp, %rbp

  # print promptText
  movq $1, %rax
  movq $1, %rdi
  leaq promptText, %rsi
  movq $38, %rdx
  syscall

  # read year as text
  movq $0, %rax
  movq $0, %rdi
  leaq yearText, %rsi
  movq $5, %rdx
  syscall

  # ascii to integer
  # thousands
  leaq yearText, %rbx
  movb (%rbx), %al
  subb $48, %al
  movzbw %al, %ax
  imulw $1000, %ax
  # hundreds
  movb 1(%rbx), %cl
  subb $48, %cl
  movzbw %cl, %cx
  imulw $100, %cx
  addw %cx, %ax
  # tens
  movb 2(%rbx), %cl
  subb $48, %cl
  movzbw %cl, %cx
  imulw $10, %cx
  addw %cx, %ax
  # ones
  movb 3(%rbx), %cl
  subb $48, %cl
  movzbw %cl, %cx
  addw %cx, %ax

  movw %ax, year

  # calculation of conditions
  # year % 4
  movq $4, %rcx
  movzwq year, %rax
  cqto
  divq %rcx
  cmpq $0, %rdx

  sete isLeapyear

  # year % 100
  movq $100, %rcx
  movzwq year, %rax
  cqto
  divq %rcx
  cmpq $0, %rdx

  movq $0, %rax
  setne %al

  andb %al, isLeapyear
  
  # year % 400
  movq $400, %rcx
  movzwq year, %rax
  cqto
  divq %rcx
  cmpq $0, %rdx

  movq $0, %rax
  sete %al

  orb %al, isLeapyear

  cmpw $0, isLeapyear

  je printOutputFailure

  movq $1, %rax
  movq $1, %rdi
  leaq outputSuccess, %rsi
  movq $10, %rdx
  syscall

  jmp end

printOutputFailure:
  movq $1, %rax
  movq $1, %rdi
  leaq outputFailure, %rsi
  movq $13, %rdx
  syscall
  
  jmp end

end:
  movq $60, %rax
  movq $0, %rdi
  popq %rbp
  syscall
