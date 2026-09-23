# Sbobinature (trascrizioni delle lezioni)

**Versione 0.1** — 23/09/2026
*Come raccogliamo e lavoriamo le trascrizioni delle lezioni. Servono a tre cose:
alimentare il libro di testo (teoria), aggiornare gli argomenti svolti / Allegato A,
e raccogliere le NOTE DEI RAGAZZI (interventi, domande, spiegazioni a voce) per i
loro quaderni personali e per la "prova del nove".*

---

## 0. Principio: conservazione INTEGRALE (vincolante)

1. Tutto cio che Nicola riporta o detta, e ogni sbobinatura, si conserva **in modo
   integrale (verbatim)**: non si riassume e non si butta via nulla.
2. Da quella versione integrale si ricava poi la versione **lavorata** (pulita e
   strutturata). L'integrale resta sempre come fonte.

## 1. Due versioni di ogni sbobinatura

1. **Integrale (verbatim)** — esattamente cio che e stato detto, parola per parola.
   Puo contenere **nomi di minori e voci** dei ragazzi -> vive **solo in scratchpad**,
   MAI su Git.
2. **Lavorata (strutturata)** — ripulita e organizzata col template; la parte
   **senza nomi** (teoria, argomenti) va su Git e alimenta il libro di testo; la
   parte con i **nomi/note dei singoli** resta in scratchpad (per i quaderni).

## 2. Flusso di lavoro

1. **Nicola registra** la lezione (vedi sez. 3) e ottiene un **testo trascritto**.
2. **Nicola manda a Claude** il testo (o l'audio se il suo telefono lo trascrive gia).
3. **Claude conserva l'integrale** in scratchpad e produce la **versione lavorata**
   con il template (`TEMPLATE-sbobinatura.md`).
4. **Claude smista** i contenuti:
   1. teoria -> `classe-1/libro-di-testo/libro-classe1.md` (bump versione);
   2. argomenti svolti -> `ARGOMENTI-SVOLTI-2026-27.md` e foglio Allegato A;
   3. note dei singoli ragazzi -> i loro quaderni (scratchpad, coi nomi).

## 3. Come registrare e trascrivere (senza installare nulla)

1. **Col telefono (piu semplice):** app di registrazione vocale; molti telefoni
   (es. Registratore Google / Samsung) **trascrivono in automatico** mentre
   registri: a fine lezione copi il testo e lo mandi a Claude.
2. **Sul PC:** il "Registratore vocale" di Windows registra l'audio; poi il testo
   si ricava con uno strumento di trascrizione da browser (es. la funzione
   "Trascrivi" di Word online, o Google Documenti).
3. In ogni caso: a Claude serve **il TESTO** della lezione (l'audio da solo non lo
   posso ascoltare). Se il telefono trascrive gia, mandami direttamente quel testo.

## 4. Nome dei file (schema 2.9)

1. Integrale (scratchpad): `AAAAMMGG_Sbobinatura-Integrale_Classe-N-PerTutti.txt`.
2. Lavorata: `AAAAMMGG_Sbobinatura_Classe-N-PerTutti_vX.Y.md` (la parte su Git e senza nomi).

## 5. Changelog

1. **v0.1 (23/09/2026)**: prima versione. Principio di conservazione integrale;
   due versioni (integrale in scratchpad, lavorata su Git senza nomi); flusso e
   modi per registrare/trascrivere.
