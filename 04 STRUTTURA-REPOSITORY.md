# 04 Struttura del repository

Versione 1.0 — 16/08/2026

L'albero del repository del corso: cosa c'è e come è organizzato. Serve per capire
a colpo d'occhio dove sta ogni cosa, e per far vedere ai ragazzi com'è fatto un
vero repository. La mappa descrittiva del materiale sta invece nel documento
02 Indice.

## 1. Com'è organizzato adesso (colpo d'occhio)

```
corso-godot/
├── 00 CORSO.md / .pdf            quadro generale del corso
├── 01 GLOSSARIO.md / .pdf        termini e sigle spiegati
├── 02 INDICE.md / .pdf           mappa di tutto il materiale
├── 03 SCALETTA-LEZIONI.md / .pdf piano delle lezioni
├── 04 STRUTTURA-REPOSITORY.md    questo documento
├── REGOLE-DOCUMENTI.md / .pdf    regole di formattazione dei documenti
├── README.md / .pdf              porta d'ingresso del repository
├── CLAUDE.md                     preferenze e contesto del corso
├── RIPRENDIAMO-DA-QUI.md / .pdf  nota di lavoro tra una sessione e l'altra
├── CORSO-COMPLETO-vX.Y.pdf       la super-guida: tutti i documenti in un PDF
│
├── manuale/                      i materiali didattici per i ragazzi
│   ├── manuale.md                libro di testo (sorgente)
│   ├── manuale-vX.Y.pdf          libro di testo (PDF versionato)
│   ├── eserciziario.md           esercizi coi 4 livelli di aiuto (sorgente)
│   ├── eserciziario-vX.Y.pdf     esercizi (PDF versionato)
│   ├── quaderno-studente-TEMPLATE.md   modello del quaderno personale
│   ├── immagini/                 gli screenshot richiamati nel libro
│   └── _build/                   strumenti che generano i PDF (li usa Claude)
│
├── esercizi/                     progetti Godot pronti, uno per cartella
│   ├── 01-bottone-che-saluta/
│   ├── 02-muovi-il-quadrato/
│   ├── 03-prendi-la-moneta/
│   └── 04-acchiappa-le-stelle/
│
├── consegne/                     kit per raccogliere e correggere i lavori
│   ├── CREA-ACCOUNT-GITHUB.md
│   ├── INVITO-ALLA-CLASSE.md
│   ├── _MODELLO/                 il kit vuoto che i ragazzi copiano
│   ├── _PROF/                    solo prof: come correggere e valutare
│   └── 2026-2027-1informatica/   un esempio già compilato
│
├── (giochi, un progetto Godot per cartella)
│   ├── battaglia-navale-3d/      Affonda la Bonomi
│   ├── gioco-del-quindici/       il 15 puzzle
│   ├── acchiappa-la-talpa/
│   ├── schiva-gli-asteroidi/
│   ├── rompi-i-mattoni/
│   ├── torta-in-faccia/
│   ├── chirurgo-pasticcione/     primo gioco (backup)
│   └── acchiappa-le-stelle/      mini gioco di esempio
│
├── docs/                         la cartella pubblicata sul web (GitHub Pages)
│   ├── index.html                Affonda la Bonomi
│   ├── quindici/ talpa/ asteroidi/ mattoni/ torta/   i giochi web
│   └── cassaforte/               l'app cassaforte
│
└── .github/workflows/
    └── deploy-pages.yml          pubblica docs/ sul web a ogni modifica
```

## 2. Le cartelle, una per una

1. `manuale/`: i materiali didattici. Contiene il libro di testo, l'eserciziario,
   il modello del quaderno, le immagini e gli strumenti di generazione dei PDF
   nella sottocartella `_build/`.
2. `esercizi/`: i progetti Godot già pronti della Fase 1, uno per cartella, che i
   ragazzi aprono e provano.
3. `consegne/`: il kit per la consegna e la correzione dei lavori, con le guide,
   il modello vuoto, la parte per il prof e un esempio compilato.
4. Le cartelle dei giochi, una per gioco, ognuna un progetto Godot completo con
   il suo `project.godot`, la scena, lo script e le immagini.
5. `docs/`: la cartella che GitHub Pages pubblica sul web. Dentro ci sono le
   versioni giocabili dei giochi e l'app cassaforte.
6. `.github/workflows/`: contiene `deploy-pages.yml`, che pubblica `docs/` sul web
   a ogni modifica del ramo `main`.

## 3. I documenti in radice

1. I documenti tecnici numerati, da 00 a 04, più le regole di formattazione, il
   README, la nota di contesto CLAUDE e la nota di lavoro RIPRENDIAMO.
2. La super-guida `CORSO-COMPLETO-vX.Y.pdf`: l'unione di tutti i documenti in un
   solo PDF, con Sommario e segnalibri.
3. Ogni documento esiste in doppio formato: MD (sorgente) e PDF (generato).

## 4. Dove si arriverà, il layout obiettivo

1. Il ramo `main` è l'area di lavoro del prof, sempre aggiornata.
2. Le release taggate, come v1.0 e v1.1, sono le versioni congelate e stabili
   consegnate ai ragazzi.
3. Alla Fase 2, coi progetti di gruppo, si aggiungerà una cartella
   `progetto-gruppo/`: un gioco che cresce con branch, Pull Request e release,
   dove i ragazzi imparano a lavorare in team.
4. I ragazzi lavorano su una loro copia, il fork, mai sul repository del prof.

## Changelog

| Versione | Data | Cosa è cambiato |
|---|---|---|
| 1.0 | 16/08/2026 | Prima stesura: albero del repository attuale e layout obiettivo della Fase 2. |
