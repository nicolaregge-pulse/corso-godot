# Corso Godot — tutto quello che abbiamo creato

*Quadro completo del corso, aggiornato al 15/08/2026. Tiene traccia di tutto:
manuale, esercizi, giochi, documenti e strumenti. Per l'elenco sempre vivo dei
percorsi vedi anche INDICE-DEL-MATERIALE.*

---

## Il manuale — libro di testo, versione 0.19

Teoria di Godot spiegata ai ragazzi, con il ponte da Lazarus e le foto
dell'ambiente. File sorgente `manuale/manuale.md`, PDF `manuale-v0.19.pdf`.

Schede iniziali:
- Scheda 1 — Come si valutano i compiti
- Scheda 2 — Scrivere in Markdown
- Scheda 3 — La tua copia del corso, e come consegnare

Capitoli:
- Capitolo 0 — Cos'è Godot, il parente di Lazarus
- Capitolo 1 — I 4 concetti base di Godot
- Capitolo 2 — GDScript, il linguaggio
- Capitolo 3 — I mattoncini, uno alla volta, 11 micro-lezioni a scoperta graduale
- Capitolo 4 — Costruiamo l'Esercizio 1, il bottone che saluta
- Capitolo 5 — Costruiamo l'Esercizio 2, muovi il quadrato
- Capitolo 6 — Costruiamo l'Esercizio 3, prendi la moneta
- Capitolo 7 — Costruiamo l'Esercizio 4, acchiappa le stelle
- Capitolo 8 — Il percorso, dagli esercizi al progetto boss

---

## L'eserciziario — versione 0.15

Gli esercizi per i ragazzi, ognuno con i 4 livelli di aiuto a scoperta graduale:
descrizione, aiuto, la scena, codice completo. Sorgente `manuale/eserciziario.md`,
PDF `eserciziario-v0.15.pdf`.

- Esercizio 1 — Il bottone che saluta
- Esercizio 2 — Muovi il quadrato
- Esercizio 3 — Prendi la moneta
- Esercizio 4 — Acchiappa le stelle
- Esercizio BOSS — Affonda la Bonomi

Più il quaderno dello studente, il portfolio personale che ogni ragazzo fa
crescere: `manuale/quaderno-studente-TEMPLATE.md`.

---

## Gli esercizi pronti — progetti Godot

Progetti funzionanti, uno per cartella, tutti avviati e verificati senza errori.
Convenzione dei nomi: la variabile finisce in Var, il nodo nella scena in Scena.

- `esercizi/01-bottone-che-saluta/`
- `esercizi/02-muovi-il-quadrato/`
- `esercizi/03-prendi-la-moneta/`
- `esercizi/04-acchiappa-le-stelle/`

---

## I giochi — giocabili dal browser, anche da telefono

Aprili e giochi, senza installare niente.

- Affonda la Bonomi, battaglia navale 3D
  https://nicolaregge-pulse.github.io/corso-godot/
- Gioco del Quindici, con la foto incorporata e le tessere di legno
  https://nicolaregge-pulse.github.io/corso-godot/quindici/
- Acchiappa la talpa, le talpe spuntano dalla terra e le tocchi a tempo
  https://nicolaregge-pulse.github.io/corso-godot/talpa/
- Schiva gli asteroidi, muovi la navetta a triangolo e sopravvivi
  https://nicolaregge-pulse.github.io/corso-godot/asteroidi/
- Rompi i mattoni, racchetta e pallina che spaccano il muro
  https://nicolaregge-pulse.github.io/corso-godot/mattoni/
- Torta in faccia, tiri col dito e centri il bersaglio sulla faccia
  https://nicolaregge-pulse.github.io/corso-godot/torta/

Sorgenti Godot nelle cartelle omonime in radice. Ogni gioco ha le costanti
FALLO TUO in cima al codice, per la personalizzazione.

---

## La Cassaforte

App che chiude un file con una password, tutto sul dispositivo, niente in rete.
Online: https://nicolaregge-pulse.github.io/corso-godot/cassaforte/

---

## Il kit di consegna dei ragazzi — cartella `consegne/`

Tutto per raccogliere e correggere i lavori, con guide in MD e in PDF.

- `CREA-ACCOUNT-GITHUB` — come i ragazzi si fanno l'account.
- `INVITO-ALLA-CLASSE` — la guida del primo giro, dal fork alla prima consegna.
- `_MODELLO/` — il kit vuoto che i ragazzi copiano, con scheda e istruzioni.
- `_PROF/` — solo prof: come correggere, i quattro segnali e la scala del voto.
- Un esempio già compilato in `2026-2027-1informatica/rossi-mario/es1-bottone/`.

Regola presa: le attività coi ragazzi, account e primo giro, si fanno in classe
a settembre, non prima.

---

## Guide, note e strumenti

- `SCALETTA-LEZIONI` — il piano delle prime lezioni, lezione per lezione.
- `INDICE-DEL-MATERIALE` — la mappa sempre aggiornata di tutti i percorsi.
- `RIPRENDIAMO-DA-QUI` — dove siamo e cosa manca tra una sessione e l'altra.
- `manuale/_build/` — gli strumenti che generano i PDF: `genera_pdf` per manuale
  ed eserciziario, `guida_pdf` per le guide e i documenti.

Tutti i documenti del corso sono disponibili sia in Markdown sia in PDF.

---

## Come è organizzato e versionato

- `main` è l'area di lavoro del prof, sempre aggiornata.
- Le **Release** taggate, come `v1.0` e `v1.1`, sono le versioni congelate e
  stabili per i ragazzi.
- I giochi web si pubblicano da soli su GitHub Pages a ogni modifica, dalla
  cartella `docs/`.
- I ragazzi lavorano su una loro copia, il fork, mai sul repository del prof.
