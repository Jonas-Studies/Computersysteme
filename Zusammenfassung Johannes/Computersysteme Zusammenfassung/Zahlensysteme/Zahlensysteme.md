Date: 2024-06-17 09:08
Parent: [[Computersysteme Zusammenfassung]] 
Topics: #computersysteme/zahlensysteme

# Zahlensysteme

| dual  | oktal | dezimal | hexadezimal |
| ----- | ----- | ------- | ----------- |
| 0     | 0     | 0       | 0           |
| 1     | 1     | 1       | 1           |
| 10    | 2     | 2       | 2           |
| 11    | 3     | 3       | 3           |
| 100   | 4     | 4       | 4           |
| 101   | 5     | 5       | 5           |
| 110   | 6     | 6       | 6           |
| 111   | 7     | 7       | 7           |
| 1000  | 10    | 8       | 8           |
| 1001  | 11    | 9       | 9           |
| 1010  | 12    | 10      | A           |
| 1011  | 13    | 11      | B           |
| 1100  | 14    | 12      | C           |
| 1101  | 15    | 13      | D           |
| 1110  | 16    | 14      | E           |
| 1111  | 17    | 15      | F           |
| 10000 | 20    | 16      | 10          |

## Umwandlung zwischen Zahlensystemen

### Allgemeine Umwandlung

Folgendes gilt für alle Umwandlungen $10\longleftrightarrow b>1$
![[Umwandlung zwischen Zahlensystemen.png]]

### Umwandlung von Basen $b=2^{n}$

Dualtetraden:
$$
101001011110000011110_{2}\longleftrightarrow 0001\ 0100\ 1011\ 1100\ 0001\ 1110_{2}\longleftrightarrow 1\ 4\ B\ C\ 1\ E_{16}=14BC1E_{16}
$$

Dualtriaden:
$$
101001011110000011110_{2}\longleftrightarrow 101\ 001\ 011\ 110\ 000\ 011\ 110_{2}\longleftrightarrow 5\ 1\ 3\ 6\ 0\ 3 6_{8}\longleftrightarrow 5136036_{8}
$$

## Einheiten für Speichergrößen

Gleiches gilt für die Darstellung in bits.

| Einheit        | Größe (byte) | Einheit        | Größe (byte) |
| -------------- | ------------ | -------------- | ------------ |
| Kilobyte (KB)  | $10^{3}$     | Kibibyte (KiB) | $2^{10}$     |
| Megabyte (MB)  | $10^{6}$     | Mebibyte (MiB) | $2^{20}$     |
| Gigabyte (GB)  | $10^{9}$     | Gibibyte (GiB) | $2^{30}$     |
| Terabyte (TB)  | $10^{12}$    | Tebibyte (TiB) | $2^{40}$     |
| Petabyte (PB)  | $10^{15}$    | Pebibyte (PiB) | $2^{50}$     |
| Exabyte (EB)   | $10^{18}$    | Exbibyte (EiB) | $2^{60}$     | 
| Zettabyte (ZB) | $10^{21}$    | Zebibyte (ZiB) | $2^{70}$     |
| Yottabyte (YB) | $10^{24}$    | Yobibyte (YiB) | $2^{80}$     |

### Datenspeicher-Einheiten

Die x86-64 Architektur unterstützt eine Menge von Datengrößen:

| Speichereinheit | bytes | bit |
| --------------- | ----- | --- |
| Byte            | 1     | 8   |
| Word            | 2     | 16  |
| Double word     | 4     | 32  |
| Quadword        | 8     | 64  |
| Double quadword | 16    | 128 | 
