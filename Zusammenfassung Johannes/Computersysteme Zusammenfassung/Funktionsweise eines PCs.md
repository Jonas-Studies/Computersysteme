Date: 2024-06-17 08:53
Parent: [[Computersysteme]]
Topics: #computersysteme #computersysteme/pc-funktionsweise

# Funktionsweise eines PCs

## Befehlszyklus

|     |                |                                     |
| --- | -------------- | ----------------------------------- |
| 1   | Fetch          | Befehl laden                        |
| 2   | Update         | Befehlszähler inkrementieren        |
| 3   | Decode         | Entschlüsselung des Befehls         |
| 4   | Fetch Operands | Laden von Operands in Datenregister |
| 5   | Execution      | Ausführung                          | 

### Hardware-Pipelining

Es wird hier zur Einfachheit nur Fetch, Decode und Execute aufgeführt.
Verschiedene Schritte können gleichzeitig ausgeführt werden, wodurch signifikant Zeit gespart wird.

| 1   | 2   | 3   | 4   | 5   | 6   | 
| --- | --- | --- | --- | --- | --- |
| F   |     |     |     |     |     |
|     | D   |     |     |     |     |
|     | F   | E   |     |     |     |
|     |     | D   | E   |     |     |
|     |     | F   | D   | E   |     |
|     |     |     | F   | D   | E   |
|     |     |     |     | F   | D   |
|     |     |     |     |     | F   |

Es kann jedoch passieren, dass Befehle sich gegenseitig beeinflussen, was das Pipelining schwierig macht.

- **Strukturgefährdung**: Zwei Anweisungen versuchen, dieselbe funktionale Einheit der Pipeline zu nutzen
- **Datenrisiko**: Eine Anweisung hängt von einer vorherigen Anweisung in der Pipeline ab, wodurch Daten verloren oder beschädigt werden könnten
- **Steuerungsrisiko**: Abrufen und Dekodieren des nächsten Befehls wird aufgrund einer Entscheidung im Steuerfluss beeinflusst (eg. bedingter Sprung)

## [[Register und Aufrufkonventionen]]