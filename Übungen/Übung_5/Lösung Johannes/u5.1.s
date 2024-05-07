.section .data
    C61: .quad 61
    C5: .quad 5
    C7: .quad 7
    CNEG17: .quad -17

    FORMAT: .asciz "x: %lld\ny: %lld\n"

.section .bss
    .lcomm x, 8
    .lcomm y, 8

.section .text
.global main
.type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp

    # x = 0, y = 0
    movq $0, y(%rip)
    movq $0, x(%rip)

    # rax = 61 / 5
    movq C61(%rip), %rax
    cqo
    movq C5(%rip), %rcx
    idivq %rcx

    # y += 61 % 5
    addq %rdx, y(%rip)

    # rax = rax * 7
    imul C7(%rip), %rax

    # rax = rax / (-17)
    cqo
    movq CNEG17(%rip), %rcx
    idivq %rcx

    # x = rax
    movq %rax, x(%rip)

    # y += rax % (-17)
    addq %rdx, y(%rip)

    # print x and y
    leaq FORMAT(%rip), %rdi
    movq x(%rip), %rsi
    movq y(%rip), %rdx
    call printf
    
    mov $0, %rax
    popq %rbp
    ret
