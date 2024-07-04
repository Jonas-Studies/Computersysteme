Date: 2024-06-17 15:38
Parent: [[Computersysteme Zusammenfassung]]
Topics: #computersysteme/gnu-assembler

# GNU Assembler

## Programmaufbau

```
.section .text
.global _start

_start:
	# Syscall exit
	mov $60, %rax
	xor %rdi, %rdi
	syscall
```

```
.section .text
.global main

main:
	push %rbp
	mov %rsp, %rbp

	mov $0, %rax

	mov %rbp, %rsp
	pop %rbp
	ret
```


