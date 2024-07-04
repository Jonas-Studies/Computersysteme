.section .rodata
    format: .asciz "Sum = %ld\n"

.section .bss
    .lcomm results 16

.section .data
.align 16
    farr1: .float 13.99, 17.4, 2.0, 3.0
.align 16
    farr2: .float -214.0, 0.75, 5.5, 30.52

.section .text
    .global main
        .type main, @function
    .global truncDec
        .type truncDec, @function

main:
    pushq %rbp
    movq %rsp, %rbp


    movq $farr1, %rax
    movq $results, %rbx

    # expression 1
    vmovss (%rax), %xmm0
    vmovss 4(%rax), %xmm1
    vsubss %xmm1, %xmm0, %xmm0
    vmovss %xmm0, (%rbx)

    # expression 2
    vmovss 8(%rax), %xmm0
    vmovss 12(%rax), %xmm1
    sqrtss %xmm0, %xmm0
    sqrtss %xmm1, %xmm1
    vaddss %xmm0, %xmm1, %xmm0
    vmovss %xmm0, 4(%rbx)


    movq $farr2, %rax

    # expression 3
    vmovss (%rax), %xmm0
    vmovss 4(%rax), %xmm1
    vmulss %xmm0, %xmm1, %xmm0
    vmovss %xmm0, 8(%rbx)

    # expression 4
    vmovss 8(%rax), %xmm0
    vmovss 12(%rax), %xmm1
    vmulss %xmm0, %xmm0, %xmm0
    vmaxss %xmm0, %xmm1, %xmm0
    vmovss %xmm0, 12(%rbx)


    # call truncDec
    leaq results, %rdi
    call truncDec

    # call printf
    leaq format, %rdi
    movq %rax, %rsi
    movq $0, %rax
    call printf

    # exit main
    movq $0, %rax
    popq %rbp
    ret


truncDec:
    movq $results, %rax

    vmovss (%rax), %xmm0

    vmovss 4(%rax), %xmm1
    vaddss %xmm0, %xmm1, %xmm0

    vmovss 8(%rax), %xmm1
    vaddss %xmm0, %xmm1, %xmm0

    vmovss 12(%rax), %xmm1
    vaddss %xmm0, %xmm1, %xmm0

    vcvttss2siq %xmm0, %rax

    ret
