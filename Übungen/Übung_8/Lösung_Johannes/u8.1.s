// Gruppe CS3-01

.section .bss
  .lcomm result, 8

// int64_t arr[] = {1004, 999, 729, -33, 1002, 1006, 2000};
.section .rodata
  arr:
    .quad 1004
    .quad 999
    .quad 729
    .quad -33
    .quad 1002
    .quad 1006
    .quad 2000

  jump_table:
    .quad case_999
    .quad case_default
    .quad case_default
    .quad case_1002
    .quad case_default
    .quad case_1004
    .quad case_default
    .quad case_1006


.section .text
.global _start

_start:
  // for (int i = 0; i <= 6; i++);  i in rsi
  movq $-1, %rsi

  for_top:
    inc %rsi
    cmp $6, %rsi
    jg for_end

    // arr[i]
    movq arr(, %rsi, 8), %rax

    // out of jump table
    cmp $999, %rax
    jl case_out_of_range

    cmp $1006, %rax
    jg case_out_of_range

    // jump_table[arr[i]]()
    sub $999, %rax
    movq jump_table(, %rax, 8), %rax
    call *%rax

    jmp for_top

  for_end:

  // Syscall to exit
  mov $60, %rax
  xor %rdi, %rdi
  syscall


case_out_of_range:
  call case_default
  jmp for_top

case_999:
  movq $1, result
  ret

case_1002:
  movq $2, result
  ret

case_1004:
case_1006:
  movq $3, result
  ret

case_default:
  movq $0, result
  ret
