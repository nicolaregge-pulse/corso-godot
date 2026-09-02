# Corso Informatica

**Versione 1.16** — 02/09/2026
*Documento indice per il docente. Raccoglie in un solo posto **tutto** ciò che
abbiamo prodotto: ogni documento, ogni esempio, ogni progetto — con la versione e
lo stato di ciascuno. È l'evidenza completa del lavoro. Si aggiorna man mano che
il corso cresce.*

> **C'è anche il "libro unico".** Oltre a questo indice, esiste
> `LIBRO-COMPLETO.md` (+ PDF): un **unico libro** che contiene **dentro** tutti i
> documenti del corso nella loro ultima versione, con **indice cliccabile e
> segnalibri navigabili**. Si rigenera con un comando ogni volta che un documento
> cambia (vedi Parte 4).

---

## In breve

Tutto il materiale sta nel **repository del corso** (`corso-godot`), sul branch
`claude/corso-informatica-classe-1-hom2pq`. Ogni documento segue la regola
**doppio formato**: una fonte `.md` (versionata) e un `.pdf` consegnabile, con il
numero di versione nel nome del file.

Il lavoro è organizzato in **quattro parti**:

1. **Classe 1 — Informatica** → il corso nuovo (programma + progetto negozio online).
2. **Corso Godot / GDScript** → il manuale, l'eserciziario e i giochi di esempio.
3. **Materiale del triennio** → gli esami, le griglie e le rubriche (in raccolta).
4. **Strumenti** → il generatore dei PDF e i file di configurazione.

---

## Parte 0 — Documenti di pianificazione (trasversali ai quattro anni)

Nella **radice del repository** stanno i documenti che governano tutto il corso,
non un anno solo. Si leggono dal generale al dettaglio: dalla mappa delle
macro-aree, alla scelta di quale anno, fino all'ora di lezione.

| Documento | Cos'è | Versione |
|---|---|---|
| `00-STATO-DEL-CORSO.md` | La **fonte di verità**: missione, decisioni confermate, stato attuale. | 2.2 |
| `01-GLOSSARIO.md` | Il **glossario** dei termini del corso. | 1.0 |
| `MAPPA-ARGOMENTI.md` | Le **macro-aree** del corso, unendo i programmi ufficiali col materiale nostro; indica anche di chi è ciascuna area. | 1.3 |
| `GRIGLIA-ARGOMENTI.md` | La **griglia** macro-area → argomenti con la spunta dell'anno (1ª/2ª/3ª/4ª) e la colonna **Competenza (Allegato A)**. Completa su tutti i 12 capitoli. | 1.13 |
| `PIANO-ORE-LEZIONE.md` | La **guida giorno per giorno**: l'albero macro-area → sotto-argomento → **singola ora di lezione**, con una breve descrizione di cosa fare in ogni ora. È il documento da guardare prima di ogni lezione. | 0.3 |
| `ORGANIZZAZIONE-GIT-ALLIEVI.md` | Come organizziamo **Git per la classe**: un'organizzazione comune con un **repository privato per ogni allievo** (GitHub Classroom). | 0.1 |
| `REGOLE-LABORATORIO.md` | Le **regole del laboratorio** di informatica: rispetto, cura delle postazioni, carta e penna, uso di internet/AI, con una versione breve da appendere. | 0.1 |
| `RUOLI-CLASSE.md` | I **ruoli della classe** (a rotazione, per tutti e 4 gli anni): i tre adottati sono **Rallentatore**, **Guardiano di Carta e Penna**, **Responsabile del Laboratorio**. | 0.3 |
| `PROMEMORIA-NICOLA.md` | La **lista viva** delle cose che Nicola deve fare (a scuola/al PC), tenuta aggiornata da Claude; si rilegge all'inizio della scuola. | 0.1 |
| `STRUTTURA-REPOSITORY.md` | L'**albero del repository**: com'è ora e come sarà a regime. | 1.2 |
| `programmi-ufficiali/` (README + 4 PDF) | I **programmi ufficiali** (Allegato A) delle classi, con nota su struttura e workflow di fine anno per la Regione. | 0.6 |
| `programma-svolto/` (cartella) | I **programmi svolti** per anno e classe (Allegato A vivo), da consegnare alla Regione. Organizzati in `<anno>/<classe>/`. | — |
| `ARGOMENTI-SVOLTI.md` | Gli **argomenti gia svolti** da ogni classe l'anno scorso (2025/26), materia unica + Sicurezza separata, con la nomenclatura nuova 26/27. Base per pianificare e per il programma svolto. | 0.2 |
| `MIE-PARTI-ALLEGATO-A.md` | **Le parti di Regge** estratte dai 4 Allegato A/PFP ufficiali, per competenza e anno (sono sparse tra piu competenze); elenco senza numerazione. | 0.2 |
| `PROGRAMMA-PREVENTIVO-2026-27.md` | Il **programma previsto** di quest'anno per ogni classe, per competenza; da incollare nell'Allegato A (senza numerazione) ed evidenziare in giallo. | 0.4 |
| `REGOLE-FORMATTAZIONE.md` | Lo **standard** di formattazione di tutti i documenti. | 1.3 |

Tutti questi sono anche **dentro il libro unico** (`LIBRO-COMPLETO`, vedi Parte 4).

---

## Parte 1 — Classe 1 (Informatica)

Cartella **`classe-1/`**. Il corso nuovo per la prima: taglio tecnico, tutto
online e gratuito, con un primo progetto completo e testato.

### 1.1 Documenti di programmazione (per il docente)

| Documento | Cos'è | Versione | Stato |
|---|---|---|---|
| `classe-1/programma.md` | La **mappa dell'anno**: i 6 moduli (software/editor/compilatore · reti e apparati di casa · configurazione PC su Amazon con budget · montaggio + sistema operativo · G Suite tecnica · Lazarus) e il percorso pluriennale fino a Cisco Packet Tracer. | 0.4 | ✅ pronto |
| `classe-1/bussola-mondo-del-lavoro.md` | Cosa serve davvero al **mondo del lavoro** a ragazzi di 15-17 anni: i tre cassetti (atteggiamento · le mani · le carte). Documento autonomo, da portare anche in altre chat. | 0.2 | ✅ pronto |
| `classe-1/da-far-fare-assolutamente.md` | L'elenco delle cose che i ragazzi devono **assolutamente fare con le mani** (database + SQL, il negozio). | 0.2 | ✅ pronto |
| `classe-1/MATERIALE-PRONTO.md` | L'indice del solo materiale di Classe 1 (più dettagliato di questo per la parte 1). | 1.4 | ✅ pronto |

### 1.2 Progetto 1 — "Il Mio Negozio Online" *(completo e testato)*

Un **negozio e-commerce demo**, tutto online e gratis: **vetrina** (GitHub Pages)
+ **database** condiviso della classe (Supabase) + **ordini via email**
(FormSubmit). Esempio dal vivo online: `nicolaregge-pulse.github.io/mio-negozio/`.

**Competenze che tocca:** pagina web (HTML/CSS/JavaScript) · **database + SQL** ·
email/automazione · **Git** e pubblicazione online.

Cartella `classe-1/negozio-online/`:

| File | Per chi | Cos'è | Versione |
|---|---|---|---|
| `GUIDA-RAGAZZI.md` (+ PDF) | ragazzi | Guida a **4 tappe**: negozio online → collega il database della classe → email → fallo tuo. Con **schemi illustrati** e i **primi screenshot reali** (crea repo, Pages, prodotti, ordine inviato). | 1.5 |
| `modello-negozio.html` | ragazzi | Il **file di partenza** che ogni ragazzo copia e riempie (3 valori `CAMBIA QUI`). | — |
| `PIANO-LEZIONE.md` (+ PDF) | docente | La **regia**: 3 lezioni con tempi, canovaccio per spiegare il database dal vivo, ruoli a gruppi, valutazione. | 1.1 |
| `prodotti.sql` | docente | Il **database dei prodotti** pronto da incollare in Supabase (con la sola-lettura). | — |
| `index.html` | esempio | Il negozio **già completo** del prof (quello pubblicato online). | — |
| `README.md` | docente | Note tecniche: come preparare il database condiviso e quali due valori dare ai ragazzi. | — |

Cartella `classe-1/negozio-esempio/`:

| File | Cos'è |
|---|---|
| `index.html` | Una **seconda versione di esempio** del negozio, di riferimento. |

**Stato del progetto:** pronto per l'aula. Restano, se vuoi, gli **screenshot**
nella guida e una **prova a freddo** prima della classe.

---

## Parte 2 — Corso Godot / GDScript

Il corso parallelo di programmazione con Godot. Il "manuale" ha due parti (libro
di testo + eserciziario) più il quaderno dello studente, e una serie di **giochi
di esempio** già funzionanti.

### 2.1 Il manuale (cartella `manuale/`)

| Documento | Cos'è | Versione | Stato |
|---|---|---|---|
| `manuale/manuale.md` | Il **libro di testo**: teoria di Godot spiegata partendo da Lazarus, un passo alla volta. | 0.5 | ✅ in crescita |
| `manuale/eserciziario.md` | Gli **esercizi** per i ragazzi, ognuno con i **4 livelli di aiuto** (descrizione → indizio → scena/nodi → codice completo). | 0.5 | ✅ in crescita |
| `manuale/quaderno-studente-TEMPLATE.md` | Il **quaderno personale** di ogni ragazzo (portfolio che cresce a ogni lezione). | — | ✅ pronto |
| `manuale/immagini/` | Gli **screenshot** richiamati dal manuale (ambiente Godot, giochi). | — | — |

I PDF consegnabili del manuale e dell'eserciziario sono versionati da `v0.1` a
`v0.5` (le versioni vecchie restano come storico).

### 2.2 Giochi di esempio (progetti Godot funzionanti)

| Cartella | Gioco | Cos'è |
|---|---|---|
| `chirurgo-pasticcione/` | **Il Chirurgo Pasticcione** | Il primo gioco completo (backup del progetto vivo). |
| `acchiappa-le-stelle/` | **Acchiappa le Stelle** | Mini-esempio di riferimento (movimento + raccolta). |
| `battaglia-navale-3d/` | **Affonda la Bonomi** | Prototipo di battaglia navale **in 3D** (cubo di celle, sottomarino nascosto). |
| `docs/` | (export web) | La **versione giocabile nel browser** esportata da Godot (per mostrare i giochi online). |

---

## Parte 3 — Materiale del triennio (esami · griglie · rubriche)

Cartella **`materiale-da-organizzare/`**. Area di **raccolta provvisoria**: qui è
al sicuro tutto il materiale del triennio fornito dal docente (esami, griglie,
rubriche). La sistemazione definitiva (cartelle per anno/materia, trascrizione in
MD + PDF) la faremo con calma.

Indice di navigazione completo: **`materiale-da-organizzare/INVENTARIO.md`**.

In sintesi, cosa contiene:

| Gruppo | Contenuto |
|---|---|
| ⭐ **Ufficiale (Regione Lombardia)** | La **prova di diploma** vera (Tecnico Informatico, giugno 2026) + la **rubrica ufficiale** di valutazione. |
| **A. Reti — Cisco Packet Tracer** | Esame "rete di una scuola" in due varianti anti-copia + griglie di valutazione. |
| **B. Reti — Cablaggio RJ45** | Prove pratiche di crimpatura cavi e connettività LAN fisica. |
| **C. Hardware · Windows · Triage · Preventivo** | Esami "a busta" su assemblaggio, sistema operativo, diagnosi guasti e preventivo economico. |
| **D. Valutazione** | Schede qualifica (3ª e 4ª) e rubriche Operatore Informatico. |

**Stato:** materiale al sicuro, ancora **da organizzare e trascrivere**. Il primo
passo previsto è la trascrizione dei due esami **Cisco Packet Tracer** in MD + PDF.

---

## Parte 4 — Strumenti e configurazione

| Cosa | A cosa serve |
|---|---|
| `LIBRO-COMPLETO.md` (+ PDF) | Il **libro unico**: tutti i documenti del corso in un solo file, ultima versione, con indice cliccabile e segnalibri. **Da rigenerare quando un documento cambia.** |
| `classe-1/_build/` | Il **generatore PDF** di Classe 1: da ogni `.md` produce il `.pdf` impaginato, con la versione nel nome. |
| `classe-1/_build/assembla_libro.py` | Lo strumento che **ricostruisce il libro unico** dai singoli documenti (poi il PDF con `genera_pdf.js` e `PDF_OUTLINE=1`). |
| `manuale/_build/` | Il **generatore PDF** del manuale Godot. |
| `CLAUDE.md` | Le **preferenze e il metodo** del corso (contesto, regole, tono, coordinate complete). |
| `README.md` | Panoramica del repository e concetti base. |

> **Come si aggiorna il libro unico** (quando cambia un documento): dalla cartella
> `classe-1/_build/` si lancia `python3 assembla_libro.py` e poi
> `PDF_OUTLINE=1 node genera_pdf.js`. Se il contenuto è cambiato, si alza la
> `LIBRO_VERSION` in cima ad `assembla_libro.py`.

---

## Dove sta tutto

Repository **`corso-godot`**, branch `claude/corso-informatica-classe-1-hom2pq`.
Ogni documento ha la sua fonte `.md` e, dove è un consegnabile, il `.pdf` accanto,
con il numero di versione nel nome del file.

Questo documento (`CORSO-INFORMATICA.md`) è **l'indice generale**: parti da qui per
avere sott'occhio tutto ciò che esiste.
