# Programma svolto (per anno e per classe)

**Versione 1.0** — 02/09/2026

Questa cartella raccoglie i **programmi effettivamente svolti**, cioe l'Allegato A
aggiornato di ogni classe: la storia reale degli argomenti trattati. E il documento
che, a fine anno, si consegna (copia-incolla) alla Regione.

## Come e organizzata (anno come nodo, poi la classe)
```
programma-svolto/
  <anno-scolastico>/
    <classe>/
      allegato-a_<classe>_<anno-scolastico>.md   (+ .pdf)
```

Esempio:
```
programma-svolto/2025-26/2INF/allegato-a_2INF_2025-26.md
```

## Convenzioni
1. Nodo principale: l'anno scolastico (es. `2025-26`). Cosi si prende tutto un anno in un colpo, come serve per la consegna annuale alla Regione.
2. Dentro l'anno, una cartella per classe con la sigla semplice: `1INF`, `2INF`, `3INF`, `4INF`.
3. Nome del file: `allegato-a_<classe>_<anno-scolastico>` (es. `allegato-a_3INF_2025-26`). Cosi classe e anno sono sempre nel nome e due versioni non si confondono.
4. Contenuto organizzato per AREA DI COMPETENZA dell'Allegato A e, dentro, per annualita: e l'ordine del documento ufficiale.
5. Ogni documento e vivo: cambia per classe e per anno, e si aggiorna quando si fanno cose nuove o le si sposta di anno.

## Come si riempie
1. Il docente esporta il registro (Excel) della classe.
2. Claude legge le voci svolte e le colloca nella competenza e nell'annualita giuste (la colonna "Comp." della Griglia degli Argomenti fa da ponte).
3. Si genera l'Allegato A aggiornato della classe (MD + PDF), pronto per la Regione.
