# Programmi ufficiali di informatica (Allegato A — riferimento)

**Versione 0.5** — 18/08/2026
*Nota di riferimento sugli allegati ufficiali (Allegato A) e sul flusso di fine
anno per la Regione. Accompagna i quattro PDF ufficiali nella cartella
`programmi-ufficiali/`.*

---

Questa cartella contiene i documenti ufficiali forniti dal docente (Nicola).

## Natura dell'Allegato A (importante): documento vivo, per classe
1. L'Allegato A NON e una "Bibbia" fissa ne uno standard a cui conformarsi: e il programma EFFETTIVAMENTE SVOLTO per una classe specifica, cioe la storia reale degli argomenti trattati in quella coorte.
2. Cambia ogni anno: quello di una classe e diverso da quello dell'anno precedente e sara diverso da quello dell'anno successivo.
3. Si puo e si deve modificare: quando si fanno cose nuove, o si spostano argomenti in anni diversi, l'Allegato A di quella classe si aggiorna di conseguenza.
4. E quindi un documento DESCRITTIVO (cosa e stato fatto), non prescrittivo. I quattro file qui sono la fotografia dell'ultimo anno per quelle classi; servono come base di partenza e come riferimento, ma si evolvono.

## Cosa sono davvero (verificato leggendo i PDF)
1. I file "prima", "seconda" e "terza" sono tutti lo **stesso tipo di documento**: l'"ALLEGATO A al Piano Formativo Personalizzato per Operatore Informatico".
2. Il modello ha sempre gli slot per tutto il triennio (I / II / III Anno), ma ogni coorte li **riempie man mano che avanza**. Quindi quanto e "pieno" un file dipende dall'anno in cui si trova quella classe (verificato leggendo i documenti):
   1. `prima` -> compilato SOLO il I anno (II e III vuoti).
   2. `seconda` -> compilati I e II anno (III vuoto).
   3. `terza` -> compilati I, II e III anno.
3. Il documento e organizzato **per competenze** (competenze alfabetiche/comunicazione, linguistica, tecnico-professionali, cittadinanza, IRC, scienze motorie, ecc.), e dentro ogni competenza gli argomenti sono divisi in "I Anno / II Anno / III Anno". E per questo che gli argomenti di informatica risultano sparsi su piu aree.
4. La **quarta** e un documento a parte: contiene solo la quarta, non gli anni precedenti.
5. Dentro gli argomenti sono spesso indicati i docenti: per l'informatica compaiono "Prof. Panaccione" (informatica di base: Google Workstation, foglio di calcolo, e in III anno sito/HTML) e "Regge" (in III anno: social, comunicazione sul web, netiquette, progetto finale, tesina, introduzione a Cisco Packet Tracer). Altre aree sono di altri docenti ("Erba", "Meles", robotica/arduino/stampa 3D, cittadinanza, diritto, IRC, scienze motorie, tirocinio).

## I file e le coorti
| File | I.D. Corso | Sezione | Annualita coperte |
|---|---|---|---|
| `programma-ufficiale-prima.pdf` | 55328 | 1 INF-Spe. | I 2025-26 · II 2026-27 · III 2027-28 |
| `programma-ufficiale-seconda.pdf` | 45316 | 2 INF Spe | I 2024-25 · II 2025-26 · III 2026-27 |
| `programma-ufficiale-terza.pdf` | 35402 | 3 INFO | I 2023-24 · II 2024-25 · III 2025-26 |
| `programma-ufficiale-quarta.pdf` | (quarta a se) | 4 INFO | solo IV anno |

Le tre coorti sono sfalsate di un anno: lo stesso Allegato A, compilato via via
per la classe che avanza.

## Come si usa l'Allegato A durante l'anno (convenzione del docente)
1. A inizio anno si evidenzia in GIALLO tutto cio che si ha intenzione di fare in quell'annualita.
2. Durante l'anno, voce per voce, ci sono due casi:
   1. Voce FATTA -> si toglie solo l'evidenziazione (il testo resta).
   2. Voce NON fatta -> si toglie la voce stessa (si cancella dal documento).
3. Risultato a fine anno: niente piu giallo, e nel documento resta scritto SOLO cio che e stato davvero svolto. Quello e il "programma svolto".
4. Quindi il giallo indica sempre "pianificato ma non ancora fatto".

## Cosa si produce a fine anno (documento per la Regione) — DELIVERABLE
1. A fine anno, Claude genera il testo del "programma svolto" ORGANIZZATO PER AREA DI COMPETENZA e PER ANNUALITA, nello stesso ordine dell'Allegato A, pronto da COPIARE E INCOLLARE nel documento che la scuola invia alla Regione.
2. Per far cadere ogni argomento nella competenza giusta serve una corrispondenza tra le nostre materie/macro-aree (Mappa e Griglia) e le competenze dell'Allegato A: e il ponte tra il nostro corso e il formato ufficiale.
3. Fonte del "cosa e stato svolto": l'ESPORTAZIONE DEL REGISTRO (registro elettronico), che il docente fornisce per ogni classe. Claude legge i divisori/voci del registro e colloca ciascuno nella competenza e nell'annualita giuste dell'Allegato A. I materiali del corso (Piano delle Ore, programmi) e i gialli de-evidenziati restano un riscontro di supporto.
4. Prerequisito per collocare in automatico: la corrispondenza materia/macro-area nostra <-> competenza Allegato A (il "ponte"), da costruire una volta.

## Note d'uso
1. Questi PDF sono la fotografia dell'ultimo anno per quelle classi. Non sono immutabili: l'Allegato A di ciascuna classe si modifica e si aggiorna quando si fanno cose nuove o le si sposta di anno. Ogni anno il documento e diverso.
2. Il confronto argomento per argomento con il nostro corso e nella Mappa e nella Griglia degli Argomenti (radice del repository).
3. Non tutto cio che c'e in questi programmi e informatica pura o materia di Regge: alcune parti sono di altri docenti o di altre aree (nell'Allegato A compaiono per esempio riferimenti a "Meles"). Vedi la colonna "di chi e" nella Mappa.
4. Dato che ogni Allegato A copre I-II-III insieme, per capire cosa e specifico di un anno si guarda la sezione "N Anno" dentro ciascuna competenza.
