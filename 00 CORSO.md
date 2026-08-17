# 00 Corso Godot — tutto quello che abbiamo creato

Versione 1.1 — 16/08/2026

Quadro completo del corso: manuale, esercizi, giochi, documenti e strumenti. Per
l'elenco sempre aggiornato dei percorsi vedi anche il documento 02 Indice.

## 1. Il manuale, libro di testo, versione 0.20

1. Teoria di Godot spiegata ai ragazzi, con il ponte da Lazarus, il sommario
   cliccabile e le foto dell'ambiente e del gioco di ogni esercizio. Sorgente
   `manuale/manuale.md`, PDF `manuale-v0.20.pdf`.
2. Schede iniziali:
   1. Scheda 1, come si valutano i compiti.
   2. Scheda 2, scrivere in Markdown (MD: il modo semplice di scrivere i testi).
   3. Scheda 3, la tua copia del corso e come consegnare.
3. Capitoli:
   1. Capitolo 0, cos'è Godot, il parente di Lazarus.
   2. Capitolo 1, i 4 concetti base di Godot.
   3. Capitolo 2, GDScript, il linguaggio.
   4. Capitolo 3, i mattoncini, uno alla volta, 11 micro-lezioni a scoperta
      graduale.
   5. Capitolo 4, costruiamo l'Esercizio 1, il bottone che saluta.
   6. Capitolo 5, costruiamo l'Esercizio 2, muovi il quadrato.
   7. Capitolo 6, costruiamo l'Esercizio 3, prendi la moneta.
   8. Capitolo 7, costruiamo l'Esercizio 4, acchiappa le stelle.
   9. Capitolo 8, il percorso, dagli esercizi al progetto boss.

## 2. L'eserciziario, versione 0.15

1. Gli esercizi per i ragazzi, ognuno con i 4 livelli di aiuto a scoperta
   graduale: descrizione, aiuto, la scena, codice completo. Sorgente
   `manuale/eserciziario.md`, PDF `eserciziario-v0.15.pdf`.
2. Elenco degli esercizi:
   1. Esercizio 1, il bottone che saluta.
   2. Esercizio 2, muovi il quadrato.
   3. Esercizio 3, prendi la moneta.
   4. Esercizio 4, acchiappa le stelle.
   5. Esercizio boss, Affonda la Bonomi.
3. C'è anche il quaderno dello studente, il portfolio personale che ogni ragazzo
   fa crescere: `manuale/quaderno-studente-TEMPLATE.md`.

## 3. Gli esercizi pronti, progetti Godot

1. Progetti funzionanti, uno per cartella, tutti avviati e verificati senza
   errori. Convenzione dei nomi: la variabile finisce in Var, il nodo nella
   scena finisce in Scena.
2. Cartelle:
   1. `esercizi/01-bottone-che-saluta/`.
   2. `esercizi/02-muovi-il-quadrato/`.
   3. `esercizi/03-prendi-la-moneta/`.
   4. `esercizi/04-acchiappa-le-stelle/`.

## 4. I giochi, giocabili dal browser anche da telefono

1. Aprili e giochi, senza installare niente. I quattro giochi arcade (talpa,
   asteroidi, mattoni, torta) hanno i suoni e una classifica online condivisa
   dei primi 10: a fine partita si scrive il nome con una tastiera a bottoni e si
   sfidano tutti gli altri giocatori.
2. Indirizzi dei giochi:
   1. Affonda la Bonomi, battaglia navale in 3D.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/
      ```
   2. Gioco del Quindici, con la foto incorporata e le tessere di legno.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/quindici/
      ```
   3. Acchiappa la talpa, le talpe spuntano dalla terra e le tocchi a tempo.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/talpa/
      ```
   4. Schiva gli asteroidi, muovi la navetta a triangolo e sopravvivi.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/asteroidi/
      ```
   5. Rompi i mattoni, racchetta e pallina che spaccano il muro.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/mattoni/
      ```
   6. Torta in faccia, tiri col dito e centri il bersaglio sulla faccia.

      ```
      https://nicolaregge-pulse.github.io/corso-godot/torta/
      ```
3. I sorgenti Godot sono nelle cartelle omonime in radice. Ogni gioco ha le
   costanti FALLO TUO in cima al codice, per la personalizzazione.

## 5. La cassaforte

1. App che chiude un file con una password, tutto sul dispositivo, niente in
   rete. Online:

   ```
   https://nicolaregge-pulse.github.io/corso-godot/cassaforte/
   ```

## 6. Il kit di consegna dei ragazzi, cartella consegne

1. Tutto per raccogliere e correggere i lavori, con guide in MD e in PDF.
2. Contenuto:
   1. Crea account GitHub, come i ragazzi si fanno l'account.
   2. Invito alla classe, la guida del primo giro, dal fork alla prima consegna.
   3. Modello, il kit vuoto che i ragazzi copiano, con scheda e istruzioni.
   4. Prof, solo per il docente: come correggere, i quattro segnali e la scala
      del voto.
   5. Un esempio già compilato in
      `consegne/2026-2027-1informatica/rossi-mario/es1-bottone/`.
3. Regola presa: le attività coi ragazzi, account e primo giro, si fanno in
   classe a settembre, non prima.

## 7. Guide, note e strumenti

1. Documento 03 Scaletta lezioni, il piano delle prime lezioni, lezione per
   lezione.
2. Documento 02 Indice, la mappa sempre aggiornata di tutti i percorsi.
3. Documento 01 Glossario, i termini e le sigle spiegati.
4. Nota di servizio interna RIPRENDIAMO-DA-QUI, dove siamo e cosa manca tra una
   sessione e l'altra.
5. Cartella `manuale/_build/`, gli strumenti che generano i PDF: `genera_pdf`
   per manuale ed eserciziario, `guida_pdf` per le guide e i documenti,
   `volume_pdf` per la super-guida combinata.
6. Tutti i documenti del corso sono disponibili sia in Markdown sia in PDF.

## 8. Come è organizzato e versionato

1. Il ramo `main` è l'area di lavoro del prof, sempre aggiornata.
2. Le release taggate, come v1.0 e v1.1, sono le versioni congelate e stabili
   per i ragazzi.
3. I giochi web si pubblicano da soli su GitHub Pages a ogni modifica, dalla
   cartella docs.
4. I ragazzi lavorano su una loro copia, il fork, mai sul repository del prof.
