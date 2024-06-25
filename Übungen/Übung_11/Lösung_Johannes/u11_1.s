.section .rodata
    format_char: .asciz "%c"
    emptystring: .asciz ""
    word: .ascii "ABC"
    word_len = . - word  # Let the compiler calculate the length of the string


.section .text
    .global main
    .type main, %function

    .global printReverse
    .type printReverse, %function

main:
    pushq %rbp
    movq %rsp, %rbp

    leaq word(%rip), %rdi
    movl $word_len, %esi
    call printReverse

    leaq emptystring(%rip), %rdi
    call puts

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
