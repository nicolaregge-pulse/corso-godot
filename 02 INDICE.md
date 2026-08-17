# 02 Indice del materiale del corso

Versione 1.1 — 16/08/2026

Mappa di tutto quello che c'è nel corso, con una riga di descrizione per ogni
voce. Si aggiorna a ogni aggiunta o cambiamento.

## 1. Manuale, cartella manuale

1. Libro di testo: `manuale/manuale.md`, versione 0.20. PDF pronto
   `manuale/manuale-v0.20.pdf`. La teoria di Godot, spiegata ai ragazzi, con il
   sommario cliccabile, le foto dell'ambiente e del gioco di ogni esercizio 1-4 e
   i capitoli di costruzione.
2. Eserciziario: `manuale/eserciziario.md`, versione 0.15. PDF pronto
   `manuale/eserciziario-v0.15.pdf`. Gli esercizi coi quattro livelli di aiuto,
   la guida passo passo e la spiegazione del codice riga per riga.
3. Quaderno dello studente: `manuale/quaderno-studente-TEMPLATE.md`. Il modello
   del manuale personale che ogni ragazzo fa crescere lezione dopo lezione.
4. Immagini: `manuale/immagini/`. Gli screenshot richiamati nel libro.

## 2. Esercizi funzionanti, cartella esercizi

1. Progetti Godot già pronti, uno per cartella. Convenzione dei nomi: la
   variabile finisce in Var, il nodo nella scena finisce in Scena.
2. Cartelle:
   1. `esercizi/01-bottone-che-saluta/`.
   2. `esercizi/02-muovi-il-quadrato/`.
   3. `esercizi/03-prendi-la-moneta/`.
   4. `esercizi/04-acchiappa-le-stelle/`.

## 3. Giochi

1. Giocabili subito dal telefono o dal browser, anche a computer spento. I
   quattro giochi arcade (talpa, asteroidi, mattoni, torta) hanno i suoni e la
   classifica online condivisa dei primi 10 giocatori: a fine partita si scrive
   il nome con una tastiera a bottoni e il punteggio va in una classifica unica
   per tutti, su un database Firebase.
2. Indirizzi:
   1. Affonda la Bonomi, battaglia navale 3D.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/
      ```
   2. Gioco del Quindici, con la foto incorporata e le tessere di legno.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/quindici/
      ```
   3. Acchiappa la talpa.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/talpa/
      ```
   4. Schiva gli asteroidi.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/asteroidi/
      ```
   5. Rompi i mattoni.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/mattoni/
      ```
   6. Torta in faccia.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/torta/
      ```
3. Sorgenti Godot dei giochi, in radice:
   1. `battaglia-navale-3d/`, Affonda la Bonomi.
   2. `gioco-del-quindici/`, il 15 puzzle.
   3. `acchiappa-la-talpa/`, le talpe da toccare a tempo.
   4. `schiva-gli-asteroidi/`, la navetta che schiva i sassi.
   5. `rompi-i-mattoni/`, racchetta, pallina e muro di mattoni.
   6. `torta-in-faccia/`, tiro alla torta su un bersaglio a cerchi sulla faccia.
   7. `chirurgo-pasticcione/`, primo gioco, il vassoio che prende gli organi.
   8. `acchiappa-le-stelle/`, mini gioco di esempio, la navetta che prende le
      stelle.

## 4. Cassaforte, app personale

1. App che chiude un file con una password, tutto sul dispositivo. Online:

   ```
   https://nicolaregge-pulse.github.io/corso-godot/cassaforte/
   ```
2. Sorgente pubblicata: `docs/cassaforte/index.html`.

## 5. Kit di consegna dei ragazzi, cartella consegne

1. Tutto per raccogliere e correggere i lavori dei ragazzi.
2. Contenuto:
   1. `consegne/CREA-ACCOUNT-GITHUB.md`, come i ragazzi si fanno l'account
      GitHub, si fa in classe il primo giorno.
   2. `consegne/INVITO-ALLA-CLASSE.md`, la guida del primo giro, dal fork alla
      prima consegna, tutta da browser.
   3. `consegne/_MODELLO/`, il kit vuoto che i ragazzi copiano: `scheda.md` e
      `ISTRUZIONI.md`, che spiega anche come vengono valutati.
   4. `consegne/_PROF/`, solo prof: `COME-CORREGGO.md` con i quattro segnali e la
      scala del voto, e `valutazione-MODELLO.md`.
   5. `consegne/2026-2027-1informatica/rossi-mario/es1-bottone/`, un esempio già
      compilato, da far vedere alla classe.

## 6. Versione consegnata ai ragazzi

1. Release v1.0, la versione congelata e stabile pubblicata per i ragazzi.

## 7. Documenti tecnici e di servizio

1. Documento 00 Corso, il quadro completo di tutto quello che abbiamo creato, in
   un unico riepilogo stampabile.
2. Documento 01 Glossario, i termini e le sigle del corso spiegati.
3. Documento 03 Scaletta lezioni, il piano delle prime lezioni della Fase 1:
   cosa spiegare, in che ordine, con quale esercizio, con la piccola vittoria da
   mostrare a ogni lezione.
4. Documento 04 Struttura del repository, l'albero del repository: com'è
   organizzato adesso e dove si arriverà con la Fase 2.
5. `REGOLE-DOCUMENTI.md`, le regole di formattazione dei documenti del corso.
6. `CORSO-COMPLETO-v1.3.pdf`, la super-guida: tutti i documenti, con le immagini,
   in un solo PDF, con Sommario e segnalibri cliccabili. Si genera con
   `manuale/_build/volume_pdf.py`.
7. `README.md`, la porta d'ingresso del repository, rimanda a questo indice.
8. `CLAUDE.md`, preferenze e contesto del corso.
9. Nota di servizio interna RIPRENDIAMO-DA-QUI, dove siamo e cosa manca tra una
   sessione e l'altra.
10. `docs/`, la cartella che viene pubblicata sul web da GitHub Pages.
11. `.github/workflows/deploy-pages.yml`, pubblica `docs/` sul web a ogni
    modifica.
