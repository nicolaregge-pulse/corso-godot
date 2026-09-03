# Struttura del Repository

**Versione 1.2** — 18/08/2026
*Mappa del repository su GitHub: cosa c'e ora e come sara l'albero completo.
Serve per orientarsi e per sapere in anticipo dove andranno le cose.*

---

## 1. A cosa serve
1. Mostra come sono organizzati i file del corso su GitHub.
2. Distingue cio che esiste gia da cio che e previsto, cosi si conosce in anticipo l'albero finale.
3. Convenzione: le voci con "(previsto)" non esistono ancora; sono la meta verso cui si va.

## 2. Albero attuale

```
corso-godot/
├── 00-STATO-DEL-CORSO.md  (+ .pdf)     documento 00: fonte di verita
├── 01-GLOSSARIO.md  (+ .pdf)           documento 01: glossario
├── REGOLE-FORMATTAZIONE.md  (+ .pdf)   standard di formattazione
├── STRUTTURA-REPOSITORY.md  (+ .pdf)   questa mappa
├── MAPPA-ARGOMENTI.md  (+ .pdf)        macro-aree (di chi e ciascuna)
├── GRIGLIA-ARGOMENTI.md  (+ .pdf)      argomenti x anno + colonna competenze
├── PIANO-ORE-LEZIONE.md  (+ .pdf)      guida ora per ora (4 anni)
├── ORGANIZZAZIONE-GIT-ALLIEVI.md (+pdf) repository per allievo (Classroom)
├── REGOLE-LABORATORIO.md  (+ .pdf)     regole del laboratorio
├── CORSO-INFORMATICA.md  (+ .pdf)      indice generale
├── LIBRO-COMPLETO.md  (+ .pdf)         il libro unico (generato)
├── CLAUDE.md                           istruzioni interne (assistente)
├── README.md                           panoramica del repository
│
├── programmi-ufficiali/                Allegato A ufficiale (4 PDF) + nota
├── programma-svolto/                   programmi svolti per <anno>/<classe> (Regione)
│
├── classe-1/                           CORSO CLASSE 1 (completo)
│   ├── programma.md  (+ .pdf)          mappa dell'anno
│   ├── bussola-mondo-del-lavoro.md     mondo del lavoro (tre cassetti)
│   ├── da-far-fare-assolutamente.md    gli irrinunciabili
│   ├── MATERIALE-PRONTO.md  (+ .pdf)   indice del materiale di Classe 1
│   ├── negozio-online/                 progetto "Il Mio Negozio Online"
│   │   ├── GUIDA-RAGAZZI.md  (+ .pdf)  guida a 4 tappe (ragazzi)
│   │   ├── PIANO-LEZIONE.md  (+ .pdf)  regia delle lezioni (docente)
│   │   ├── modello-negozio.html        file di partenza dei ragazzi
│   │   ├── index.html · prodotti.sql   esempio completo + database
│   │   └── immagini/                   schemi + screenshot della guida
│   ├── negozio-esempio/index.html      seconda versione di esempio
│   └── _build/                         generatore dei PDF del corso
│
├── classe-2/programma.md  (+ .pdf)     programma Classe 2 (v0.2)
├── classe-3/                           programma + reti-teoria + esercizi
│   ├── programma.md  (+ .pdf)          programma Classe 3 (v0.2)
│   ├── reti-teoria.md  (+ .pdf)        teoria delle reti (con schemi SVG)
│   └── esercizi/01-cablaggio-rj45.md   scheda cablaggio a 4 livelli
├── classe-4/programma.md  (+ .pdf)     programma Classe 4 (v0.2)
│
├── manuale/                            CORSO GODOT (2a/3a)
│   ├── manuale.md  (+ .pdf)            libro di testo di Godot
│   ├── eserciziario.md  (+ .pdf)       esercizi a 4 livelli
│   ├── quaderno-studente-TEMPLATE.md   quaderno personale dei ragazzi
│   ├── immagini/                       screenshot del manuale
│   └── _build/                         generatore PDF del manuale
│
├── esercizi/                           esercizi Godot (in crescita)
├── acchiappa-le-stelle/                gioco di esempio
├── chirurgo-pasticcione/               gioco di esempio
├── battaglia-navale-3d/                gioco di esempio (3D)
├── docs/                               versione giocabile nel browser (export web)
└── materiale-da-organizzare/           esami del triennio (grezzi, da trascrivere)
```

## 3. Albero obiettivo (dove vogliamo arrivare)

Rispetto ad oggi si aggiungono le cartelle per anno e la sistemazione del
materiale del triennio.

```
corso-godot/
├── (documenti di riferimento: 00, 01, regole, struttura, indice, libro)
│
├── classe-1/                           FATTO (corso completo)
│
├── classe-2/                           Godot + GDScript, Lazarus, intro reti
│   ├── programma.md  (avviato v0.1)
│   ├── esercizi/     (previsto)
│   └── progetti/     (previsto)
│
├── classe-3/                           reti e hardware + prove di 3a
│   ├── programma.md  (avviato v0.1)
│   └── prove/        (previsto)        reti / hardware
│
├── classe-4/                           Cisco Packet Tracer avanzato
│   ├── programma.md  (avviato v0.1)
│   └── rete-scolastica/  (previsto)    dorsale a due piani, tre backbone
│
├── manuale/                            corso Godot (condiviso 2a/3a)
├── giochi-esempio/  (previsto)         i giochi raccolti in un'unica cartella
└── materiale-da-organizzare/           si svuota man mano: le prove trascritte
                                        vanno in classe-3/ e classe-4/
```

## 4. Note

> [BLU] La parte "(previsto)" e la direzione concordata: puo cambiare mentre il corso cresce. Questo documento si aggiorna quando l'albero cambia.

> [GIALLO] Le cartelle `_build/` contengono gli strumenti che generano i PDF: non sono materiale per i ragazzi.
