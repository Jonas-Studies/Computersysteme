.section .rodata
    format: .asciz "%llu\n%#llx\n"

.section .text
.global main
.type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp

    movq $888888888888, %rax

    # Set the lower 32 bits of %rrax to 0, and then or in 777777
    movq $0xFFFFFFFF00000000, %rdx
    andq %rdx, %rax
    movq $777777, %rdx
    orq %rdx, %rax

    movb $30, %al
    movb $31, %ah

    # Print contents of %rax using printf
    movq %rax, %rsi
    movq %rax, %rdx
    leaq format(%rip), %rdi
    movq $0, %rax
    call printf

    mov $0, %eax
    popq %rbp
    ret
