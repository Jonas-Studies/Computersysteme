Date: 2024-07-01 10:35
Parent: [[Comutersysteme]]
Topics: #computersysteme/kontrollstrukturen

# Kontrollstrukturen

## If-Else

### If

```c
if (rax == 1) {
	func1();
}
```

```asm
cmpq $1, %rax
jne if_end

call func1

if_end:
```

### If-Else

```c
if (rax == 1) {
	func1();
}
else {
	func2();
}
```

```asm
cmpq $1, %rax
je if_start

call func2
jmp if_end

if_start:
call func1

if_end:
```

### If-Elif-Else

```c
if (rax == 1) {
	func1();
}
else if (rax == 2) {
	func2();
}
else {
	func3();
}
```

```asm
cmpq $1, %rax
je if_start

cmpq $2, %rax
je elif_start

call func3
jmp ifelif_end

if_start:
call func1
jmp ifelif_end

elif_start:
call func2
jmp ifelif_end

ifelif_end:
call func2

ifelif_end:
```

## For

```c
for (int i = 0; i < 10; i++) {
	func1();
}
```

```asm
movq $0, %rax
movq $10, %rcx

jmp for_condition

for_start:
call func1

for_condition:

cmpq %rcx, %rax
jle for_start
```

## While

```c
while (rax == 1) {
	func1();
}
```

```asm
jmp while_condition

while_start:
call func1

while_condition:
cmpq $1, %rax
je while_start
```

## Do-While

```c
do {
	func1();
} while (rax == 1);
```

```asm
do_while:
call func1

cmpq $1, %rax
je do_while
```
