# Come si genera il PDF del libro di testo

**Versione 1.0** — 02/09/2026

Questa cartella contiene gli **strumenti** che trasformano il sorgente
`../manuale.md` (con le immagini di `../immagini/`) nel PDF impaginato
`../manuale.pdf`.

> ⚠️ **Per Nicola:** questa parte la esegue **Claude**, non serve che tu tocchi
> la riga di comando. A te basta:
> 1. mettere le immagini in `manuale/immagini/` (con il nome atteso dal manuale);
> 2. scrivere/aggiornare `manuale.md`;
> 3. chiedere a Claude «rigenera il PDF».
>
> Il tuo lavoro resta **tutto visuale** (GitHub Desktop / browser). Questi script
> sono versionati solo perché il PDF sia **riproducibile** in modo identico.

## Cosa fa

1. **`genera_pdf.py`** — legge `manuale.md`, costruisce una copertina (logo
   Godot + titolo + versione), incorpora le immagini nel documento, evidenzia il
   codice GDScript e produce un HTML impaginato *self-contained* (`manuale.html`,
   intermedio, non versionato).
2. **`genera_pdf.js`** — apre quell'HTML con Chromium e lo stampa in PDF A4
   (`../manuale.pdf`), con numeri di pagina a piè di pagina.
3. **`anteprima.js`** — (opzionale) genera un'anteprima PNG per controllare la
   resa a schermo.

## Come rigenerare (comandi per Claude)

Dalla cartella `manuale/_build/`:

```bash
# 1) HTML impaginato con immagini incorporate
python3 genera_pdf.py

# 2) PDF finale (serve Chromium; percorso via variabile d'ambiente)
CHROMIUM_PATH="$(ls -d /opt/pw-browsers/chromium-*/chrome-linux/chrome | head -1)" \
NODE_PATH="$(npm root -g)" node genera_pdf.js
```

Dipendenze: `python3` con il modulo `markdown`; `node` con `playwright`
(Chromium). Il PDF risultante è `../manuale.pdf`.

## Regola del corso (dal CLAUDE.md)

- Il **`.md` è la fonte di verità** versionata.
- Il **PDF è la resa consegnabile** generata dall'`.md`.
- Quando cambia il contenuto si **bumpa la versione** nell'intestazione di
  `manuale.md` e si aggiunge una voce al changelog in fondo.
