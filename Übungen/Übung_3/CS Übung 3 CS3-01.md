# 3.1

## a.

signed short

## b.

word

## c.

1000 0010 0100 0001

## d.

$$2^0+2^6+2^9-2^{15}=1+64+512-32768=-32191$$

## e.

```asm
movw $33345, r14w

movw $0x8241, r14w
```

# 3.2

| Operation | Wert (binär) | Wert (dezimal) signed | Wert (dezimal) unsigned |
| --- | --- | --- | --- |
| x | `10001000` | -120 | 136 |
| x << 4 | `10000000` | -128 | 128 |
| x >> 4 (arithmetisch) | `11111000` | -8 | 121 |
| x >> 4 (logisch) | `00001000` | 8 | 8 |

# 3.3

| Operand | Wert |
| %rax | 0x1000 // Register |
| 0x1004 | 0x1004 // Memory (absolute) |
| $0x1004 | 0x1004 // Immediate |
| (%rax) | 0x10 // Memory (indirect) Adresse 0x1000 |
| 4(%rax) | 0x11 // Memory (indexed) Adresse 0x1004 |
| 3(%rax, %rdx) | 0x12 // Memory (indexed) Adresse 0x1008 |
| 0x201(%rcx,%rdx) | Wert an Adresse 0x208 // Memory (indexed) |
| 0x20(,%rcx,4) | Wert an Adresse 0x28 // Memory (indexed) |
| (%rax,%rdx,8) | Wert an Adresse 0x1028 // Memory (indexed) |
