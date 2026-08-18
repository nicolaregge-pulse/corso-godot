# Scheda Configuratore PC

**Versione 0.1** — 17/08/2026
*Scheda pratica di Classe 1 (area hardware). Serve a configurare un PC scegliendo
componenti compatibili tra loro, partendo dalla scheda madre. Per ogni componente
si scrive marca, modello, costo e link (Amazon o altro sito), e soprattutto la
sua compatibilita, cioe il vincolo che impone ai pezzi successivi.*

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

## 4. La tabella da compilare
Compila una riga per componente. Nella colonna "Compatibilita" scrivi il dato-vincolo (formato, socket, tipo di RAM, ecc.).

| Componente | Marca | Modello | Compatibilita (dato-vincolo) | Costo | Link |
|---|---|---|---|---|---|
| Scheda madre |  |  | formato: ___ · socket: ___ · RAM: ___ · PCIe: ___ |  |  |
| Case |  |  | accetta formato: ___ |  |  |
| Processore (CPU) |  |  | socket: ___ |  |  |
| Dissipatore |  |  | per socket: ___ |  |  |
| Memoria RAM |  |  | tipo: ___ · numero moduli: ___ |  |  |
| Scheda video (GPU) |  |  | slot PCIe x16 · lunghezza: ___ |  |  |
| Disco (SSD/HDD) |  |  | connettore: M.2 / SATA |  |  |
| Alimentatore (PSU) |  |  | potenza: ___ W · connettori |  |  |
| TOTALE |  |  |  | euro ___ |  |

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
