# Gruppe CS3-01

.section .data
.align 16


# Minimal gepackte Struktur
.globl struct1
    .type struct1, @object
    .size struct1, 13
struct1:
    .byte 'x' # char c;
    .long 1 # int i;
    .quad struct1 + 1 # int *pN;


# Natural Alignment
.globl struct2
    .type struct2, @object
    .size struct2, 16
struct2:
    .byte 'x' # char c;
    .zero 3 # padding
    .long 10 # int i;
    .quad struct2 + 4 # int *pN;


# Optimierung des Alignment durch Umordnung
.globl struct3
    .type struct3, @object
    .size struct3, 16
struct3:
    .long 100 # int i;
    .quad struct3 # int *pN;
    .byte 'x' # char c;
    .zero 3 # padding


.section .text
.globl main

main:
    pushq %rbp
    movq %rsp, %rbp

    # Zwischenergebnis in rax
    movq $0, %rax

    movq struct1+5(%rip), %r10 # r10 = struct1.pN
    movl (%r10), %r11d # r11 = *r10  # movl = movzlq
    addq %r11, %rax

    movq struct2+8(%rip), %r10 # r10 = struct2.pN
    movl (%r10), %r11d # r11 = *r10
    addq %r11, %rax

    movq struct3+4(%rip), %r10 # r10 = struct3.pN
    movl (%r10), %r11d # r11 = *r10
    addq %r11, %rax

    popq %rbp
    ret
    