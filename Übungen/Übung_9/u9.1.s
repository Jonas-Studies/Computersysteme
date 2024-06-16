# Gruppe CS3-01

.section .data
aSh:
  .word 1, 2, 3, 4
  .word 5, 6, 7, 8
  .word 9, 10, 11, 12

.section .text
.globl main
.type main, @function

main:
  pushq %rbp
  movq %rsp, %rbp

  # rdi = &aSh
  leaq aSh(%rip), %rdi

  movq $1, %rsi # i = 1
  movq $0, %rdx # j = 0

  # rax = aSh[1][0]
  leaq (, %rsi, 4), %rax
  leaq (%rdi, %rax, 2), %rax
  movzwq (%rax, %rdx, 2), %rcx

  movq $2, %rsi # i = 2
  movq $3, %rdx # j = 3

  # rax = aSh[2][3]
  leaq (, %rsi, 4), %rax
  leaq (%rdi, %rax, 2), %rax
  movzwq (%rax, %rdx, 2), %rax

  # rax = aSh[2][3] + aSh[1][0] = rax + rcx
  addq %rcx, %rax

  # return rax == 17
  cmpq $17, %rax
  movq $0, %rax
  sete %al

  popq %rbp
  ret
