# Scheda Configuratore PC

**Versione 0.2** — 17/08/2026
*Scheda pratica di Classe 1 (area hardware). Serve a configurare un PC scegliendo
componenti compatibili tra loro, partendo dalla scheda madre. Per ogni componente
si scrive marca, modello, costo e link, e si mettono le crocette sui formati e
attacchi supportati: la compatibilita si vede confrontando le crocette.*

---

## 1. La regola d'oro: si parte dalla scheda madre
1. La scheda madre (motherboard) e il componente con piu vincoli: decide cosa potrai montare dopo.
2. Ogni volta che scegli un componente, scrivi la sua compatibilita (per esempio il formato ATX, il socket, il tipo di RAM): quel dato diventa un vincolo per i pezzi che sceglierai dopo.
3. Esempio: se la scheda madre e formato ATX, potrai metterla solo in un case ATX.
4. Alla fine si controlla che tutto combaci con la checklist (punto 5).

## 2. Cosa decide la scheda madre (i vincoli che si propagano)
1. Formato (form factor): ATX, micro-ATX o mini-ITX. Vincola il CASE (deve accettare quel formato).
2. Socket della CPU: per esempio AM4, AM5, LGA1700. Vincola il PROCESSORE (stesso socket) e il DISSIPATORE.
3. Tipo di RAM e numero di slot: DDR4 oppure DDR5, e quanti banchi (moduli DIMM). Vincola la MEMORIA.
4. Slot di espansione PCIe: x16, x8, x1. Lo slot x16 vincola la SCHEDA VIDEO; gli altri le espansioni.
5. Connettori per i dischi: SATA e/o M.2. Vincolano gli SSD e gli HDD che potrai collegare.

## 3. L'ordine con cui scegliere i componenti
1. Scheda madre (prima di tutto): fissa formato, socket, tipo di RAM, slot PCIe, connettori dischi.
2. Case: deve accettare il formato della scheda madre.
3. Processore (CPU): stesso socket della scheda madre.
4. Dissipatore: adatto a quel socket e che stia nel case.
5. Memoria RAM: stesso tipo (DDR4 o DDR5), numero di moduli non superiore agli slot.
6. Scheda video (GPU): entra nello slot PCIe x16 e ci sta nel case (lunghezza).
7. Dischi (SSD/HDD): secondo i connettori della scheda madre (M.2 o SATA).
8. Alimentatore (PSU): potenza in Watt sufficiente, connettori giusti, formato che entra nel case.

## 4. Le schede dei componenti (con le crocette di compatibilita)
Per ogni componente scrivi marca, modello, costo e link, e metti una crocetta (X)
nelle caselle □ dei formati e attacchi che quel componente supporta. La
compatibilita si vede confrontando le crocette: cio che la scheda madre "e" deve
rientrare in cio che gli altri componenti "accettano".

### Scheda madre (scegli questa per prima)

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

Spunta le compatibilita:
1. Formato (uno): □ mini-ITX   □ micro-ATX   □ ATX
2. Socket (uno): □ AM4   □ AM5   □ LGA1700   □ altro (scrivi quale)
3. Tipo di RAM: □ DDR4   □ DDR5
4. Attacchi presenti: □ PCIe x16   □ M.2   □ SATA

### Case

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Formati che accetta (anche piu di uno): □ mini-ITX   □ micro-ATX   □ ATX
2. Regola: deve includere il formato spuntato sulla scheda madre.

### Processore (CPU)

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Socket (uno): □ AM4   □ AM5   □ LGA1700   □ altro (scrivi quale)
2. Regola: stesso socket della scheda madre.

### Dissipatore

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Socket compatibili (anche piu di uno): □ AM4   □ AM5   □ LGA1700   □ altro
2. Regola: deve includere il socket della scheda madre.

### Memoria RAM

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Tipo: □ DDR4   □ DDR5
2. Numero di moduli: □ 1   □ 2   □ 4
3. Regola: stesso tipo della scheda madre, non piu moduli degli slot disponibili.

### Scheda video (GPU)

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Attacco: □ PCIe x16
2. Regola: serve uno slot PCIe x16 libero sulla scheda madre; controlla la lunghezza nel case.

### Disco (SSD o HDD)

| Marca | Modello | Costo (euro) | Link |
|---|---|---|---|
|  |  |  |  |

1. Connettore: □ M.2   □ SATA
2. Regola: il connettore deve essere presente sulla scheda madre.

### Alimentatore (PSU)

| Marca | Modello | Potenza (W) | Costo (euro) | Link |
|---|---|---|---|---|
|  |  |  |  |  |

1. Formato: □ ATX   □ SFX

### Totale

| Costo totale (euro) |
|---|
|  |

## 5. Checklist di compatibilita finale
1. Il formato della scheda madre entra nel case? (esempio: ATX in un case ATX)
2. Il socket della CPU e uguale a quello della scheda madre?
3. La RAM e dello stesso tipo (DDR4 o DDR5) e non supera il numero di slot?
4. Il dissipatore e adatto a quel socket e ci sta nel case?
5. La scheda video entra nello slot PCIe x16 e nel case (lunghezza)?
6. I dischi usano connettori presenti sulla scheda madre (M.2 o SATA)?
7. L'alimentatore ha abbastanza Watt e i connettori giusti per tutti i componenti?

## 6. Consigli
1. Parti sempre dalla scheda madre, poi CPU e RAM (i piu vincolati), poi il resto.
2. Scrivi sempre marca, modello, costo e link: cosi la scheda diventa anche un preventivo, utile per il compito di realta.
3. Se un componente non rispetta un vincolo, cambialo: meglio accorgersene qui che dopo aver comprato.
