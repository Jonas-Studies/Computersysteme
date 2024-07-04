Date: 2024-06-17 10:58
Parent: [[Computersysteme Zusammenfassung]]
Topics: #computersysteme/register #computersysteme/aufrufkonventionen

# Register und Aufrufkonventionen

## Register

| Spezielle Register  | Bedeutung                                                                        |
| ------------------- | -------------------------------------------------------------------------------- |
| `rsp`               | Zeigt auf neuesten Inhalt vom Stack                                              |
| `rbp`               | Zeigt auf Anfang vom Stack-Frame der aktuellen Funktion                          |
| `rip`               | Zeigt auf den nächsten auszuführenden Befehl                                     |
| `rflags`            | Enthält Status- und CPU-Steuerinformationen, wird nach jedem Befehl aktualisiert |
| `xmm`, `ymm`, `zmm` | Fließkommazahlregister (128, 256 und 512 bit), meist `xmm0`-`xmm31`              |

| General-Purpose Register | Untere 32 bit | Untere 16 bit | Obere 8 bit | Untere 8 bit    | Bedeutung                                  |
| ------------------------ | ------------- | ------------- | ----------- | --------------- | ------------------------------------------ |
| `rax`                    | `eax`         | `ax`          | `ah`        | `al`            | Arithmetische Operationen und Rückgabewert |
| `rbx`                    | `ebx`         | `bx`          | `bh`        | `bl`            | Base Pointer für Speicherzugriff           |
| `rcx`                    | `ecx`         | `cx`          | `ch`        | `cl`            | Loop Counter                               |
| `rdx`                    | `edx`         | `dx`          | `dh`        | `dl`            | Arithmetische und I/O Operationen          |
| `rsi`                    | `esi`         | `si`          |             | `sil`           | Source Pointer für Stringoperationen       |
| `rdi`                    | `edi`         | `di`          |             | `dil`           | Destination Pointer für Stringoperationen  |
| `rbp`                    | `ebp`         | `bp`          |             | `bpl`           | _siehe oben_                               |
| `rsp`                    | `esp`         | `sp`          |             | `spl`           |                                            |
| `r8`                     | `r8d`         | `r8w`         |             | `r8b` (`r8l`)   | General Purpose                            |
| `r9`                     | `r9d`         | `r9w`         |             | `r9b` (`r9l`)   |                                            |
| `r10`                    | `r10d`        | `r10w`        |             | `r10b` (`r10l`) |                                            |
| `r11`                    | `r11d`        | `r11w`        |             | `r11b` (`r11l`) |                                            |
| `r12`                    | `r12d`        | `r12w`        |             | `r12b` (`r12l`) |                                            |
| `r13`                    | `r13d`        | `r13w`        |             | `r13b` (`r13l`) |                                            |
| `r14`                    | `r14d`        | `r14w`        |             | `r14b` (`r14l`) |                                            |
| `r15`                    | `r15d`        | `r15w`        |             | `r15b` (`r15l`) |                                            |
| `r16` (mit APX)          | `r16d`        | `r16w`        |             | `r16b` (`r16l`) |                                            |
| `r17` (mit APX)          | `r17d`        | `r17w`        |             | `r17b` (`r17l`) |                                            |
| ...                      | ...           | ...           |             | ...             |                                            |
| `r31` (mit APX)          | `r31d`        | `r31w`        |             | `r31b` (`r31l`) |                                            |

### Flag Register (rflags)

| Bit | Symbol | Name      | Verwendung                                                          |
| --- | ------ | --------- | ------------------------------------------------------------------- |
| 0   | CF     | Carry     | Übertrag bei der letzten Operation                                  |
| 2   | PF     | Parity    | Anzahl der 1en im letzten Byte ist gerade (1) oder ungerade (0)     |
| 4   | AF     | Adjust    | Übertrag von einem halben Byte zum nächsten                         |
| 6   | ZF     | Zero      | Ergebnis der letzten Operation ist 0                                |
| 7   | SF     | Sign      | MSB (Most Significant Bit) ist 1 oder 0                             |
| 10  | DF     | Direction | Richtung der Zeichenfolgenverarbeitung                              |
| 11  | OF     | Overflow  | Zahlenbereich eines Datentyps wurde überschritten                   |
|     |        |           | Bei Addition: `OF= Carry[n-2]->Carry[n-1] XOR Carry[n-1]->Carry[n]` | 

## Aufrufkonventionen

### Volatile und nicht volatile Register

- `rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`-`r11` sind volatil (=caller-saved) und dürfen vom Callee frei verwendet werden.
- `rbx`, `rbp`, `rsp`, `r12`-`r15` sind non-volatil (=callee-saved) und dürfen vom Caller frei verwendet werden.

- Alle `ymm0`-`ymm15` sind volatil.

### Funktionen

#### Funktionsargumente

- Die ersten vier Ganzzahl- oder Pointerargumente werden in `rcx`, `rdx`, `r8` und `r9` in dieser Reihenfolge übergeben.
- Die Fließkommazahlargumente werden in `xmm0`-`xmm7` übergeben.
- Der Caller muss genug Platz am Stack reservieren, damit alle übergebenen Parameter vom Callee gespeichert werden könnten.
- Alle weiteren Funktionsparameter werden am Stack gespeichert. (letzte Parameter zuerst)
- Ganzzahl- oder Pointerrückgabewerte werden in `rax` gespeichert.
- Fließkommazahlrückgabewerte werden in `xmm0` gespeichert.

#### Leaf-Funktionen

Leaf-Funktionen sind Funktionen, die keine anderen Funktionen aufrufen.
Diese sind meist sehr Stack-Freundlich.

Non-Leaf-Funktionen sind Funktionen, die andere Funktionen oder sich selbst aufrufen.

#### Funktionen mit Framepointer

Funktionen mit Framepointer haben die folgende Struktur.  
Diese haben die Eigenschaft, einfacheren Zugriff auf die Elemente im Stack (eg. Argumente) zu erlauben, haben jedoch höheren Stack-Overhead.

```asm
function_with_framepointer:
    pushq %rbp
    movq %rsp, %rbp

    # ...

    # Alternative: leave
    movq %rbp, %rsp
    popq %rbp

    ret
```

#### Rekursive Funktionen

Rekursive Funktionen rufen sich selbst auf.
Hierbei muss nicht besonders auf den Stack geachtet werden, da nach jedem return der Stack in den vorherigen Zustand gebracht werden sollte.
