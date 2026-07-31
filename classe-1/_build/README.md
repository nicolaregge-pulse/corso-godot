# Come si generano i PDF (Classe 1)

I documenti del corso stanno in `.md` (la fonte versionata). Da ogni `.md` si
genera un **PDF impaginato** con la versione nel nome (regola nel `CLAUDE.md`).
Il PDF viene salvato **accanto** al suo `.md`.

## Una volta sola: installare gli strumenti
```
pip install markdown
npm install            # dentro questa cartella (_build): scarica Playwright
```
Il browser Chromium è già presente nell'ambiente (non va riscaricato).

## Generare un PDF
Due comandi (il primo fa l'HTML, il secondo il PDF):
```
python3 genera_pdf.py <documento>
node genera_pdf.js
```

I `<documento>` disponibili:
| chiave | file sorgente | PDF prodotto |
|---|---|---|
| `guida-negozio` | `negozio-online/GUIDA-RAGAZZI.md` | `negozio-online/GUIDA-RAGAZZI-vX.Y.pdf` |
| `programma` | `programma.md` | `programma-vX.Y.pdf` |
| `bussola` | `bussola-mondo-del-lavoro.md` | `bussola-mondo-del-lavoro-vX.Y.pdf` |
| `da-far-fare` | `da-far-fare-assolutamente.md` | `da-far-fare-assolutamente-vX.Y.pdf` |

La versione nel nome del PDF viene letta dalla riga `**Versione X.Y** — data`
in cima al `.md`: se cambi il contenuto, alza il numero di versione nel `.md` e
rigenera (così non si sovrascrivono due versioni diverse).

## Nota su questo ambiente (Chromium già installato)
Se `node genera_pdf.js` dice che manca il browser, indica quello presente:
```
CHROMIUM_PATH=/opt/pw-browsers/chromium-1194/chrome-linux/chrome node genera_pdf.js
```
(il numero `1194` può cambiare: `ls /opt/pw-browsers`).

## Logo di copertina (opzionale)
Se metti un file `classe-1/immagini/logo_corso.png`, compare in copertina.
Se non c'è, la copertina resta pulita (niente logo). **Non** si usa il logo di
Godot: è un altro corso.
