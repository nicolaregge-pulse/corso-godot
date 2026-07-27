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

## Il flusso (semplice, per iniziare — Fase 1)

1. Il ragazzo **copia** la cartella `_MODELLO/` nella sua posizione
   (`ANNO-CLASSE/cognome-nome/nome-esercizio/`) e la rinomina.
2. **Compila** `scheda.md`, ci mette il suo `main.gd` e i suoi screenshot in
   `immagini/`.
3. **Carica** i file da browser (`Add file` → `Upload files`) e fa **Commit**.
   Niente branch per ora: un semplice salvataggio basta.
4. Avvisa il prof. Claude corregge, si decide il voto (numero + breve giudizio) e
   si aggiunge la pagina al manuale personale.

> I branch e le Pull Request li introdurremo in **Fase 2** (progetto di gruppo),
> quando i ragazzi avranno preso confidenza: un passo alla volta.
