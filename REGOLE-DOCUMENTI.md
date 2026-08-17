# Regole di formattazione dei documenti — Corso Godot

Versione 1.0 — 16/08/2026

Regole per come si scrivono e si consegnano i documenti del corso Godot. Questo
documento segue le regole che descrive. Fonte originale: regole del sistema
documenti; qui adattate al corso Godot (le parti specifiche del progetto Quidoo
Pulse, come STATO_PRODOTTO, Guido e VPS, non si applicano e sono segnalate).

## 1. Ambito: due categorie di documenti

1. Documenti tecnici e di servizio: INDICE, CORSO, SCALETTA, RIPRENDIAMO, le
   guide del kit consegne, i README, questo documento. Seguono lo standard
   pieno qui sotto.
2. Materiali didattici per i ragazzi: manuale, eserciziario, quaderno dello
   studente. Tengono il loro stile pedagogico (semplice, accogliente, con
   incoraggiamento), come imposto dal CLAUDE.md del corso. Di questo standard
   seguono solo le parti compatibili: doppio formato MD + PDF (regola 2),
   versione nel nome file (regola 10), termine con spiegazione (regola 8), e la
   REGOLA 0 (regola 11). Non si applicano invece: niente elenchi puntati
   (regola 6) e niente emoji (regola 7), perché lo stile amichevole e i pallini
   colorati dei livelli di aiuto dell'eserciziario servono davvero.

## 2. Formati e consegna

1. Ogni documento esiste sempre in due forme: MD (sorgente versionata) e PDF
   (generato dall'MD).
2. Consegna doppia: un PDF combinato, la super-guida, come stampa unica; e i
   singoli documenti numerati.
3. Il combinato del corso è `CORSO-COMPLETO`, generato da
   `manuale/_build/volume_pdf.py`. Ogni nuovo documento entra nel combinato,
   oltre a quelli già elencati.

## 3. Titoli

1. Numero d'ordine nel titolo e nel nome file: 00, 01, 02, 02b, e così via.
2. Nella numerazione niente trattino: si scrive `02 Panoramica`, non
   `02 — Panoramica`.
3. Titoli mai orfani: un titolo sta sulla stessa pagina dell'inizio del suo
   contenuto o della sua tabella, mai in fondo a una pagina con il contenuto
   nella pagina dopo.

## 4. Indice e navigazione

1. INDICE è la guida di lettura: elenco dei documenti, ognuno con una riga di
   descrizione.
2. La super-guida ha due indici: un Sommario stampato in testa, con documento e
   numero di pagina, e i segnalibri PDF cliccabili nella barra laterale.
   Entrambi si rigenerano da soli a ogni generazione del combinato.

## 5. Font e numerazione delle sezioni

1. Font unico nei PDF: DejaVu.
2. La numerazione delle sezioni è automatica e gerarchica.

## 6. Liste

1. Nei documenti tecnici e di servizio: solo liste numerate e gerarchiche, nella
   forma 1, poi 1.1, poi 1.1.2. Niente elenchi puntati.
2. Nei materiali didattici per i ragazzi: gli elenchi puntati restano ammessi,
   perché più leggeri e amichevoli.

## 7. Caratteri decorativi ed emoji

1. Nei documenti tecnici e di servizio: pochi o nessun emoji decorativo. Il
   generatore converte gli emoji in testo, per esempio `[CRITICO]`, `[OK]`,
   `[ATTENZIONE]`, oppure li rimuove.
2. Per evidenziare si usano i box colorati semantici della legenda (sezione 9),
   non le faccine.
3. Nei materiali didattici per i ragazzi: gli emoji con funzione restano, in
   particolare i pallini dei livelli di aiuto dell'eserciziario, perché il
   generatore li usa per colorare i livelli.

## 8. Sigle, acronimi e punteggiatura

1. Ogni sigla con la forma esplicita tra parentesi alla prima occorrenza:
   `VPS (Virtual Private Server: server privato virtuale)`.
2. I termini ricorrenti stanno nel glossario.
3. Termine con spiegazione: due punti, come in `Git: sistema di versionamento`.
4. Inciso a metà frase: virgole se leggero, parentesi se accessorio, trattino
   lungo solo per uno stacco forte voluto.
5. Notazione numerica italiana: virgola per i decimali, punto per le migliaia.
   Date nel formato giorno/mese/anno nel testo, anno-mese-giorno nei dati e nei
   database.

## 9. Box colorati: legenda canonica

1. Rosso, DISALLINEAMENTO: qualcosa che stride con la realtà o con la fonte di
   verità, cioè un errore noto da correggere.
2. Blu, DA CONFERMARE o IN ATTESA: la direzione verso cui si converge ma senza
   ufficialità. Quando arriva la conferma, il box sparisce.
3. Giallo, NOTA: semplice nota esplicativa, non segnala problemi.

## 10. Versioning

1. Una versione stampata è congelata: da lì non si tocca più.
2. Correzioni e aggiunte vanno nella versione successiva, registrate nel
   changelog della versione. Ogni versione stampata può avere una errata in coda
   al combinato.
3. Ogni documento porta la sua versione: un documento nuovo parte da 1.0. La
   super-guida ha la versione della raccolta.
4. Il numero di versione sta sempre nel nome del file PDF, per esempio
   `manuale-v0.20.pdf`, e coincide con la versione scritta nell'intestazione
   dell'MD.

## 11. Fonte di verità

1. Nel corso Godot la fonte di verità dei contenuti è il manuale, e la mappa di
   tutto il materiale è INDICE.
2. La regola del progetto Quidoo Pulse, per cui il documento 00 STATO_PRODOTTO
   di Guido è la stella polare e non si riscrive ma si recepisce, riguarda quel
   progetto e non il corso Godot.

## 12. Regola per la comunicazione all'utente

1. REGOLA 0, assoluta: tutto ciò che l'utente deve copiare, cioè comandi, URL,
   email, valori, va in un blocco di codice con il bottone copia, mai in linea
   nel testo e mai in citazione.

## Changelog

| Versione | Data | Cosa è cambiato |
|---|---|---|
| 1.0 | 16/08/2026 | Prima stesura: recepite le regole di formattazione e adattate al corso Godot, con la distinzione tra documenti tecnici e materiali didattici. |
