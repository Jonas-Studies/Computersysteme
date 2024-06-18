# Gruppe CS3-01


.section .rodata
    format: .asciz "Result: %ld\n"

.section .text
    .global main
    .type main, @function


main:
    pushq %rbp
    movq %rsp, %rbp


    # rdi = 1, rsi = 2
    movq $1, %rdi
    movq $2, %rsi

    pushq %rdi
    pushq %rsi

    # l3 = 3, l4 = 4, l5 = 5, l6 = 6
    movq $1, %rdi
    movq $2, %rsi
    movq $3, %rdx
    movq $4, %rcx
    movq $5, %r8
    movq $6, %r9

    # sum = 0, pSum = &sum
    pushq $0
    pushq %rsp

    # l7 = 7, l8 = 8
    pushq $8
    pushq $7


    call calculateSumAndMultiply


    # pop sum, pSum, l7, l8
    addq $32, %rsp


    # pop l1, l2 and add to result
    popq %rsi
    popq %rdi
    addq %rdi, %rax
    addq %rsi, %rax


    # print result
    leaq format(%rip), %rdi
    movq %rax, %rsi
    xorq %rax, %rax
    call printf


    movq %rbp, %rsp
    popq %rbp
    ret


// l1 in rdi
// l2 in rsi
// l3 in rdx
// l4 in rcx
// l5 in r8
// l6 in r9
// l7, l8, pSum on stack
calculateSumAndMultiply:
    pushq %rbp
    movq %rsp, %rbp

    # add l1 - l6
    addq %rsi, %rdi
    addq %rdx, %rdi
    addq %rcx, %rdi
    addq %r8, %rdi
    addq %r9, %rdi

    # add l7, l8
    addq 16(%rbp), %rdi
    addq 24(%rbp), %rdi

    # *pSum = sum
    movq 32(%rbp), %rdx
    movq %rdi, (%rdx)


    movq $2, %rdi
    movq $3, %rsi
    call multiply


    movq %rbp, %rsp
    popq %rbp
    ret


# mult1 in rdi
# mult2 in rsi
# pSum in rdx
# result in rax
multiply:
    pushq %rbp
    movq %rsp, %rbp
    
    movq %rdi, %rax
    imulq %rsi, %rax
    imulq (%rdx), %rax

    movq %rbp, %rsp
    popq %rbp
    ret
