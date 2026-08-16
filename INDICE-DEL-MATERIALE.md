# Indice del materiale del corso

Mappa di tutto quello che c'è nel corso, sempre aggiornata. Se aggiungiamo o
cambiamo qualcosa, si aggiorna qui.

Ultimo aggiornamento: 10/08/2026.

## Manuale, in `manuale/`

- **Libro di testo** — `manuale/manuale.md`, versione **0.19**. PDF pronto:
  `manuale/manuale-v0.19.pdf`. La teoria di Godot, spiegata ai ragazzi, con le
  foto dell'ambiente e i capitoli di costruzione degli esercizi 1-4.
- **Eserciziario** — `manuale/eserciziario.md`, versione **0.15**. PDF pronto:
  `manuale/eserciziario-v0.15.pdf`. Gli esercizi coi quattro livelli di aiuto, la
  guida passo passo e la spiegazione del codice riga per riga.
- **Quaderno dello studente** — `manuale/quaderno-studente-TEMPLATE.md`. Il
  modello del manuale personale che ogni ragazzo fa crescere lezione dopo lezione.
- **Immagini** — `manuale/immagini/`. Gli screenshot richiamati nel libro.

## Esercizi funzionanti, in `esercizi/`

Progetti Godot già pronti, uno per cartella. Convenzione dei nomi: la variabile
finisce in Var, il nodo nella scena finisce in Scena.

- `esercizi/01-bottone-che-saluta/`
- `esercizi/02-muovi-il-quadrato/`
- `esercizi/03-prendi-la-moneta/`
- `esercizi/04-acchiappa-le-stelle/`

## Giochi

Giocabili subito dal telefono o dal browser, anche a computer spento:

- **Affonda la Bonomi**, battaglia navale 3D:
  https://nicolaregge-pulse.github.io/corso-godot/
- **Gioco del Quindici**, con la foto incorporata e le tessere di legno:
  https://nicolaregge-pulse.github.io/corso-godot/quindici/
- **Acchiappa la talpa**, le talpe spuntano dai buchi e le tocchi a tempo:
  https://nicolaregge-pulse.github.io/corso-godot/talpa/
- **Schiva gli asteroidi**, muovi la navetta e sopravvivi il più a lungo:
  https://nicolaregge-pulse.github.io/corso-godot/asteroidi/
- **Rompi i mattoni**, racchetta e pallina che spaccano il muro di mattoni:
  https://nicolaregge-pulse.github.io/corso-godot/mattoni/
- **Torta in faccia**, tiri col dito e centri il bersaglio sulla faccia:
  https://nicolaregge-pulse.github.io/corso-godot/torta/

Sorgenti Godot dei giochi, in radice:

- `battaglia-navale-3d/` — Affonda la Bonomi.
- `gioco-del-quindici/` — il 15 puzzle.
- `acchiappa-la-talpa/` — le talpe da toccare a tempo.
- `schiva-gli-asteroidi/` — la navetta che schiva i sassi che cadono.
- `rompi-i-mattoni/` — racchetta, pallina e muro di mattoni da spaccare.
- `torta-in-faccia/` — tiro alla torta su un bersaglio a cerchi sulla faccia.
- `chirurgo-pasticcione/` — primo gioco, il vassoio che prende gli organi.
- `acchiappa-le-stelle/` — mini gioco di esempio, la navetta che prende le stelle.

## Cassaforte, app personale

App che chiude un file con una password, tutto sul dispositivo. Online:

- https://nicolaregge-pulse.github.io/corso-godot/cassaforte/
- Sorgente pubblicata: `docs/cassaforte/index.html`.

## Kit di consegna dei ragazzi, in `consegne/`

Tutto per raccogliere e correggere i lavori dei ragazzi.

- `consegne/CREA-ACCOUNT-GITHUB.md` — come i ragazzi si fanno l'account GitHub
  (si fa in classe il primo giorno).
- `consegne/INVITO-ALLA-CLASSE.md` — la guida del primo giro, dal fork alla prima
  consegna, tutta da browser.
- `consegne/_MODELLO/` — il kit vuoto che i ragazzi copiano: `scheda.md` e
  `ISTRUZIONI.md`, che spiega anche come vengono valutati.
- `consegne/_PROF/` — solo prof: `COME-CORREGGO.md` con i quattro segnali e la
  scala del voto, e `valutazione-MODELLO.md`.
- `consegne/2026-2027-1informatica/rossi-mario/es1-bottone/` — un esempio già
  compilato, da far vedere alla classe.

## Versione consegnata ai ragazzi

- **Release v1.0** — la versione congelata e stabile pubblicata per i ragazzi.

## Per il docente

- `SCALETTA-LEZIONI.md` — il piano delle prime lezioni della Fase 1: cosa
  spiegare, in che ordine, con quale esercizio, con la piccola vittoria da
  mostrare a ogni lezione.

## Materiale di servizio

- `CORSO.md` e `CORSO.pdf` — quadro completo di tutto quello che abbiamo creato
  (manuale, esercizi, giochi, documenti), in un unico riepilogo stampabile.
- `CORSO-COMPLETO-v1.0.pdf` — il VOLUME UNICO: tutti i documenti (con le immagini)
  in un solo PDF, con indice cliccabile e segnalibri. Si genera con
  `manuale/_build/volume_pdf.py`.
- `README.md` — la porta d'ingresso del repository, rimanda a questo indice.
- `CLAUDE.md` — preferenze e contesto del corso.
- `RIPRENDIAMO-DA-QUI.md` — dove siamo e cosa manca, tra una sessione e l'altra.
- `docs/` — la cartella che viene pubblicata sul web da GitHub Pages.
- `manuale/_build/` — gli strumenti che generano i PDF a partire dai sorgenti
  `.md`. Li usa Claude, il lavoro di Nicola resta tutto visuale.
- `.github/workflows/deploy-pages.yml` — pubblica `docs/` sul web a ogni modifica.
