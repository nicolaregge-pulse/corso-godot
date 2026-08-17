# Materiale del Corso — Classe 1 (Informatica)

**Versione 1.4** — 16/08/2026
*Documento per il docente. L'elenco di tutto il materiale pronto e degli esercizi
già fatti, con lo stato di ciascuno. Si aggiorna man mano che il corso cresce.*

---

## In breve

Il corso di **Classe 1** è impostato (programma + bussola del lavoro) e ha il suo
**primo progetto completo e testato**: il **negozio online**. Tutto è **versionato**
(ogni documento in `.md` con il suo `.pdf`) e salvato nel repository del corso.

---

## 1. Documenti di programmazione (per il docente)

| Documento | Cos'è | Versione |
|---|---|---|
| `programma.md` | La **mappa dell'anno**: i 6 moduli (software/editor/compilatore · reti · config PC su Amazon · montaggio + sistema operativo · G Suite tecnica · Lazarus) e il percorso pluriennale fino a Cisco Packet Tracer. | 0.3 |
| `bussola-mondo-del-lavoro.md` | Cosa serve davvero al **mondo del lavoro** da ragazzi di 15-17 anni: i tre cassetti (atteggiamento · le mani · le carte). | 0.1 |
| `da-far-fare-assolutamente.md` | L'elenco delle cose che i ragazzi devono **assolutamente fare con le mani**. | 0.1 |

---

## 2. Esercizi / progetti FATTI

### ✅ Progetto 1 — "Il Mio Negozio Online" *(completo e testato)*

Un **negozio e-commerce demo**, tutto online e gratis: **vetrina** (GitHub Pages)
+ **database** condiviso della classe (Supabase) + **ordini via email**
(FormSubmit). Esempio dal vivo: `nicolaregge-pulse.github.io/mio-negozio/`.

**Competenze che tocca:** pagina web (HTML/CSS/JavaScript) · **database + SQL** ·
email/automazione · **Git** e pubblicazione online. Tutte spendibili nel lavoro.

Materiale pronto (cartella `negozio-online/`):

| File | Per chi | Cos'è | Versione |
|---|---|---|---|
| `GUIDA-RAGAZZI.md` (+ PDF) | ragazzi | Guida a **4 tappe**: negozio online → collega il database della classe → email → fallo tuo. Con **schemi illustrati** e i **primi screenshot reali**. | 1.3 |
| `modello-negozio.html` | ragazzi | Il **file di partenza** che ogni ragazzo copia e riempie (3 valori `CAMBIA QUI`). | — |
| `PIANO-LEZIONE.md` (+ PDF) | docente | La **regia**: 3 lezioni con tempi, canovaccio per spiegare il database dal vivo, ruoli a gruppi, gestione dei ritmi, valutazione. | 1.0 |
| `prodotti.sql` | docente | Il **database dei prodotti** pronto da incollare in Supabase (con la sola-lettura). | — |
| `index.html` | esempio | Il negozio **già completo** del prof (quello online). | — |
| `README.md` | docente | Note tecniche: come preparare il database condiviso e quali due valori dare ai ragazzi. | — |

**Stato:** pronto per l'aula. Manca solo, se vuoi, aggiungere gli **screenshot**
nella guida e fare una **prova a freddo**.

---

## 3. Strumenti

| Cosa | A cosa serve |
|---|---|
| `_build/` | Il **generatore PDF** del corso: da ogni `.md` produce il `.pdf` impaginato, con la versione nel nome (istruzioni in `_build/README.md`). |

---

## 4. In preparazione (prossimi passi)

- **Screenshot** nella guida del negozio + **prova a freddo** prima della classe.
- Gli **altri moduli** del programma, ancora da sviluppare in libro di testo +
  esercizi: software/editor/compilatore · reti e apparati di casa · configurazione
  PC su Amazon con budget · montaggio + sistema operativo · G Suite tecnica ·
  Lazarus.

---

## Dove sta tutto

Repository del corso, branch `claude/corso-informatica-classe-1-hom2pq`,
cartella **`classe-1/`**. Ogni documento ha la sua fonte `.md` e il `.pdf`
consegnabile accanto.
