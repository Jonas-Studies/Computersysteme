.section .rodata
    format_char: .asciz "%c"
    emptystring: .asciz ""
    word: .ascii "ABC"
    word_len: .quad 3


.section .text
    .global main
    .type main, %function

    .global printReverse
    .type printReverse, %function

main:
    pushq %rbp
    movq %rsp, %rbp

    leaq word(%rip), %rdi
    movq word_len(%rip), %rsi
    call printReverse

    leaq emptystring(%rip), %rdi
    call puts

    movq $0, %rax

    movq %rbp, %rsp
    popq %rbp
    ret


# rdi: char* word
# rsi: int len
printReverse:
    pushq %rbp
    movq %rsp, %rbp

    cmpq $0, %rsi
    je printReverse_epilogue
    
    pushq %rdi
    pushq %rsi

    movzbq -1(%rdi, %rsi, 1), %rsi
    leaq format_char(%rip), %rdi
    call printf

    popq %rsi
    popq %rdi

    subq $1, %rsi
    call printReverse
    
printReverse_epilogue:
    movq %rbp, %rsp
    popq %rbp
    ret
