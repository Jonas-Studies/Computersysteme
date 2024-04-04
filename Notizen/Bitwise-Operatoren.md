# AND-Operator: &
Der AND-Operator liefert immer dann 1 wenn beide Bits gleich sind.
## Wahrheitstabelle:

| X   | Y   | &   |
| --- | --- | --- |
| 0   | 0   | 1   |
| 0   | 1   | 0   |
| 1   | 0   | 0   |
| 1   | 1   | 1   |
## Beispiel:
5 & 4 <=> 0101 & 0100 => 0100
# Exclusiv-OR-Operator: ^
Der Exclusiv-OR-Operator liefert immer dann 1 wenn beide Bits nicht gleich sind.
## Wahrheitstabelle:
| X   | Y   | ^   |
| --- | --- | --- |
| 0   | 0   | 0   |
| 0   | 1   | 1   |
| 1   | 0   | 1   |
| 1   | 1   | 0   |
## Beispiel:
5 ^ 4 <=> 0101 ^ 0100 => 0001
# OR-Operator: |
Der OR-Operator liefert immer dann 1 wenn eines der beiden Bits 1 ist.
## Wahrheitstabelle
| X   | Y   | \|  |
| --- | --- | --- |
| 0   | 0   | 0   |
| 0   | 1   | 1   |
| 1   | 0   | 1   |
| 1   | 1   | 1   
## Beispiel
5 | 4 <=> 0101 | 0100 => 0101