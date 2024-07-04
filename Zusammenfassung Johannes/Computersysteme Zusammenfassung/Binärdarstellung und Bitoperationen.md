Date: 2024-06-17 08:58
Parent: [[Computersysteme Zusammenfassung]]
Topics: #computersysteme #computersysteme/binär

# Binärdarstellung und Bitoperationen

## Signed vs Unsigned

| signed      |      | unsigned    |     |
| ----------- | ---- | ----------- | --- |
| `0100 1010` | 74   | `0100 1010` | 74  |
| `1100 1010` | -54  | `1100 1010` | 202 |
| `0111 1111` | 127  | `0111 1111` | 127 |
| `1000 0000` | -128 | `1000 0000` | 128 |
| `1111 1111` | -1   | `1111 1111` | 255 |

### Umwandlung Signed <-> Unsigned

$b=(\sim a)+1$

Beispiel:
`1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 0` $a$
`0 0 0 0 0 0 0 0 0 0 1 0 1 1 0 1` $\sim a$
`0 0 0 0 0 0 0 0 0 0 1 0 1 1 1 0` $(\sim a)+1$

## Bitoperationen

| Operation | Symbol | Beispiel        | Ergebnis    |
| --------- | ------ | --------------- | ----------- |
| NOT       | ~      | ~`0101 1010`    | `1010 0101` |
| AND       | ∧      | `1100` ∧ `1010` | `1000`      |
| OR        | ∨      | `1100` ∨ `1010` | `1110`      |
| XOR       | ⊕      | `1100` ⊕ `1010` | `0110`      |

## Shift-Operationen

| Operation            | Symbol | Beispiel         | Ergebnis    |
|----------------------|--------|------------------|-------------|
| Logischer Shift Links | <<     | `0010 1100` << 2 | `1011 0000` |
| Logischer Shift Rechts| >>     | `0010 1100` >> 2 | `0000 1011` |
| Arithmetischer Shift Rechts| >>>| `1000 1100` >>> 2| `1110 0011` |

## Endianness

Reihenfolge, in der Bytes in einem mehrbyteigen Datentyp gespeichert werden.

- **Big-Endian**: Das höchstwertige Byte ist an der niedrigsten Speicheradresse
- **Little-Endian**: Das niedrigstwertige Byte ist an der niedrigsten Speicheradresse

| Zahl         | Big-Endian   | Little-Endian |
| ------------ | ------------ | ------------- |
| `0x12345678` | `0x12345678` | `0x78563412`  |

Alle x86 und x86-64 Systeme nutzen *Little-Endian*!