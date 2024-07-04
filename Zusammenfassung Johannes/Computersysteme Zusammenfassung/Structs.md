Date: 2024-07-02 10:36
Parent: [[Computersysteme Zusammenfassung]]
Topics: #computersysteme/structs

# Structs

## Initialisierter Struct

```c
struct rec {
	int i;
	int j;
	int a[2];
	int *p;
};

struct rec svar = {1, 2, {1, 2}, NULL};

int main()
{
	//...
	return 0;
}
```

```asm
.section .data
	.align 16
	.globl svar
	.type svar, @object
	.size svar, 24
svar:
# i:
	.int 1
# j:
	.int 2
# a:
	.int 1, 2 # Array
# p:
	.quad 0
```

## Nicht initialisierter Struct

```c
struct rec {
 int i;
 int j;
 int a[2];
 int *p;
};
struct rec svar;
int main()
{
 //...
 return 0;
}
```

```asm
.section .bss
.align 16
 .lcomm svar, 24   # oder .comm
```

## Struct auf dem Stack

```c
struct rec {
 int i;
 int j;
 int a[2];
 int *p;
};
int main()
{
 struct rec svar;
 //...
 return 0;
}
```

```asm
main:
 #...
 subq $24, %rsp
 #...
```

## Alignment

- Datentypen sollen im Speicher an einer Adresse ausgerichtet, die ein vielfaches der Dateityp-Größe ist
- Ausrichtung ist möglich mithilfe der .align direktive: `.align 8`
- Bei Arrays oder Structs sollte der Anfang auf `8` byte ausgerichtet werden
- Bei großen Structs (>64 Byte) sollten auf `16` byte ausgerichtet werden
- Innerhalb von Strukturen muss eventuell **zero padding** zwischen den Elementen eingeführt werden, um natural alignment einzuhalten.
- Alle dynamischen und stack-addressen müssen ein Vielfaches von `16` sein, damit SSE-Befehle funktionieren.

