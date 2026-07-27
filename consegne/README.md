# Consegne — come sono organizzate

Qui finiscono le **consegne dei ragazzi**. Ogni consegna è una cartella con la
scheda compilata, il codice e gli screenshot. Da qui il prof (con Claude) corregge,
dà un voto e aggiunge una pagina al **manuale personale** dello studente.

## Struttura delle cartelle (per gestire più classi e più anni)

```
consegne/
  _MODELLO/                         ← il KIT VUOTO da copiare (non si tocca)
    scheda.md
    ISTRUZIONI.md
    immagini/

  2026-2027-1informatica/           ← anno scolastico + classe
    rossi-mario/                    ← lo studente (cognome-nome)
      es1-bottone/                  ← la consegna (un esercizio o un titolo)
        scheda.md
        main.gd
        immagini/
      es2-quadrato/
        ...
    bianchi-lucia/
      ...
```

Così ogni anno si crea una nuova cartella `ANNO-CLASSE/` e tutto resta in ordine
nel tempo.

## Chi lavora dove (decisione presa)

**Ogni ragazzo lavora su una SUA copia del corso** (un *fork*), mai su questo
repository. Così nessuno può toccare il lavoro degli altri, e il repo del corso
resta intatto. Nella sua copia il ragazzo mette le consegne sotto `consegne/`,
per esempio `consegne/es1-bottone/`.

Questa cartella `consegne/ANNO-CLASSE/cognome-nome/` qui nel repo del corso è
invece l'**archivio del prof**: qui il prof (con Claude) raccoglie le consegne
corrette e tiene i **manuali personali** degli studenti.

## Il flusso (semplice, per iniziare — Fase 1)

1. Una volta sola: il ragazzo si fa la **sua copia** del corso (bottone **Fork**
   su GitHub, da browser).
2. Per una consegna: **copia** `_MODELLO/` nella sua copia, la rinomina
   (es. `consegne/es1-bottone/`), **compila** `scheda.md`, ci mette `main.gd` e
   gli screenshot in `immagini/`.
3. **Carica** i file da browser (`Add file` → `Upload files`) e fa **Commit**.
   Niente branch: un semplice salvataggio nella sua copia basta.
4. Manda al prof il **link** della sua consegna. Claude corregge, si decide il
   voto (numero + breve giudizio) e si aggiunge la pagina al manuale personale.

> I branch e le Pull Request li introdurremo in **Fase 2** (progetto di gruppo),
> quando i ragazzi avranno preso confidenza: un passo alla volta.
