Date: 2024-07-01 15:08
Parent: [[Computersysteme]]
Topics: #computersysteme/fließkommazahlen

# Fließkommazahlen

## Darstellung in IEEE 754

![[Umwandlung Dezimal Binär Fließkommazahlen.png]]

$10001.101\cdot2^{0}=1.0001101\cdot2^{4}$

![[Umwandlung Binärzahl zu IEEE 754.png]]

| Typ    | Größe (1+r+p) | Exponent (r) | Mantisse (p) | Werte des Exponenten (e) | Biaswert (B) |
| ------ | ------------- | ------------ | ------------ | ------------------------ | ------------ |
| float  | 32 bit        | 8 bit        | 23 bit       | −126 ≤ _e_ ≤ 127         | 127          |
| double | 64 bit        | 11 bit       | 52 bit       | −1022 ≤ _e_ ≤ 1023       | 1023         |

$$
f=(-1)^{s}\cdot2^{r-B}\cdot(1+M/2^{p})
$$

### Sonderfälle

![[IEEE 754 Sonderfälle.jpg]]

### Rounding

Manche Fließkommazahlen können nicht in IEEE 754 dargestellt werden.
Diese Zahlen müssen gerundet werden zu entweder $x^{-}$ oder $x^{+}$.

Es wird immer zur näheren der beiden Zahlen gerundet, außer die Zahl liegt genau zwischen $x^{-}$ und $x^{+}$.
In diesem Fall sind mehrere Rechenregeln möglich.
*Round to even* ist hierbei sinnvoll, da bei den anderen Rundungsverfahren ein statistischer Fehler/Verschiebung auftreten kann.

| Regel              | $1.50$ | $2.50$ | $-1.50$ |
| ------------------ | ------ | ------ | ------- |
| Round to even      | $2.00$ | $2.00$ | $-2.00$ |
| Round towards zero | $1.00$ | $2.00$ | $-1.00$ |
| Round down         | $1.00$ | $2.00$ | $-2.00$ |
| Round up           | $2.00$ | $3.00$ | $-1.00$ |

In der Realität werden die signifikanten Nachkommastellen und die $n$ folgenden bits berechnet.
Anhand dieser $n$ bits wird dann die Rundung entschieden:

| Bits $(n=3)$ | Runding       |
| ------------ | ------------- |
| `000`-`011`  | Round down    |
| `100`        | Round to even |
| `101`-`111`  | Round up      |

### Arithmetik

#### Addition

1. Anpassung der Dezimalpunkte (Signifikanten der Zahl mit kleinerem Exponenten "shiften")
2. Addition der Signifikanten
3. Normalisieren (Exponent anpassen)
4. Runden

#### Multiplikation

1. Addition der Exponenten
2. Multiplikation der Signifikanten
3. Normalisieren
4. Runden
5. Bestimmung des Vorzeichens

## Fließkommazahl- und Vektorbefehle

> [!important] 
> Es können keine Immediate-Werte (z.B. `$12.4`) mit diesen Befehlen verwendet werden.
> Es muss dazu Speicher in `.rodata` etc. angelegt werden.

### Move

| Instruction | Source    | Destination | Description                             |
| ----------- | --------- | ----------- | --------------------------------------- |
| `vmovss`    | `M32`/`X` | `M32`/`X`   | Move single, single precision           |
| `vmovsd`    | `M64`/`X` | `M64`/`X`   | Move single, double precision           |
| `vmovaps`   | `M`/`X`   | `M`/`X`     | Move aligned, packed single precision   |
| `vmovapd`   | `M`/`X`   | `M`/`X`     | Move aligned, packed double precision   |
| `vmovups`   | `M`/`X`   | `M`/`X`     | Move unaligned, packed single precision |
| `vmovupd`   | `M`/`X`   | `M`/`X`     | Move unaligned, packed double precision | 

- packed: Move mit der Breite des gesamten FP-Registers.
- aligned: Schneller als unaligned (eg. `vmovupd`), benötigt mindestens `.align 16` .

### Typumwandlung

| Instruction  | Source      | Source 2 | Destination | Description                               |
| ------------ | ----------- | -------- | ----------- | ----------------------------------------- |
| `vcvtsi2ss`  | `M32`/`R32` | `X`      | `X`         | Convert 32bit integer to single precision | 
| `vcvtsi2sd`  | `M32`/`R32` | `X`      | `X`         | Convert 32bit integer to double precision |
| `vcvtsi2ssq` | `M`/`R64`   | `X`      | `X`         | Convert 64bit integer to single precision |
| `vcvtsi2sdq` | `M`/`R64`   | `X`      | `X`         | Convert 64bit integer to double precision |

| Instruction   | Source    | Destination | Description                                         |
| ------------- | --------- | ----------- | --------------------------------------------------- |
| `vcvttss2si`  | `X`/`M32` | `R32`       | Convert with truncation single precision to 32bit integer |
| `vcvttsd2si`  | `X`/`M64` | `R32`       | Convert with truncation double precision to 32bit integer |
| `vcvttss2siq` | `X`/`M32` | `R64`       | Convert with truncation single precision to 64bit integer |
| `vcvttsd2siq` | `X`/`M64` | `R64`       | Convert with truncation double precision to 64bit integer |

### Arithmetik

| Single   | Double   | Effect                   | Description |
| -------- | -------- | ------------------------ | ----------- |
| `vaddss` | `vaddsd` | $S_{2}+S_{1}\to D$       | Add         |
| `vsubss` | `vsubsd` | $S_{2}-S_{1}\to D$       | Subtract    |
| `vmulss` | `vmulsd` | $S_{2}*S_{1}\to D$       | Multiply    |
| `vdivss` | `vdivsd` | $S_{2}/S_{1}\to D$       | Divide      |
| `vmaxss` | `vmaxsd` | $\max(S_{2},S_{1})\to D$ | Maximum     |
| `vminss` | `vminsd` | $\min(S_{2},S_{1})\to D$ | Minimum     |
| `sqrtss` | `sqrtsd` | $\sqrt{S}\to D$          | Square Root |

### Vergleiche

| Instruction |               | Based on      | Description                         |
| ----------- | ------------- | ------------- | ----------------------------------- |
| `ucomiss`   | $S_{1},S_{2}$ | $S_{2}-S_{1}$ | Compare unordered, single precision |
| `ucomisd`   | $S_{1},S_{2}$ | $S_{2}-S_{1}$ | Compare unordered, double precision |

### Shuffle

| Instruction | Source 1 | Source 2 | Source 3 | Destination | Description                                                             |
| ----------- | -------- | -------- | -------- | ----------- | ----------------------------------------------------------------------- |
| `vshufps`   | `I8`     | `X`/`M`  | `X`      | `X`         | Move four float values in src1 and src2 with ordering specified in `I8` |
| `vshufpd`   | `I8`     | `X`/`M`  | `X`      | `X`         | Move two double values in src1 and src2 with ordering specified in `I8` |

`I8` ist eine Liste aus 2 bit Indizes, mit denen aus Source 1 und Source 2 Datenelemente geladen werden.
Leserichtung bei den Indizes ist von rechts nach links.
Die erste Hälfte der Indizes in `I8` bezieht sich auf Source 2, die zweite Hälfte auf Source 1.

![[Vec Shuffle 128 bit.png]]
![[Vec Shuffle 256 bit.png]]
