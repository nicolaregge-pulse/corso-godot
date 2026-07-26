# Battaglia Navale 3D 🌊💣 (prototipo)

Una battaglia navale **in tre dimensioni**: invece della solita griglia a righe
e colonne, c'è un **cubo** di celle d'acqua. Dentro è nascosto **un
sottomarino**. Lanci una **bomba di profondità** su una cella: esplode e colpisce
una zona **3×3×3** attorno al punto. Se il sottomarino è in quella zona → COLPITO!

> ⚠️ È una **prima bozza** fatta per Nicola, da provare e migliorare insieme
> (grafica, effetti, difficoltà). Non è ancora un esercizio per i ragazzi.

## Come si gioca
- **Clic sinistro** su una cella = lancia la bomba di profondità.
- **Frecce ← → ↑ ↓** = giri attorno al cubo (per vederlo bene in 3D).
- **INVIO** = nuova partita (nuovo sottomarino nascosto).

## Come si apre (per Nicola)
1. `[APP — Godot]` nella finestra iniziale (il *Gestore progetti*), in alto a
   destra clicca **`Importa`**.
2. Vai nella cartella **`battaglia-navale-3d`** e scegli il file **`project.godot`**,
   poi **`Importa e modifica`**.
3. Quando l'editor è aperto, in alto a destra premi **`▶`** (Esegui il progetto)
   — oppure il tasto **`F5`**.

## Cosa possiamo migliorare (idee)
- Cubo più grande (parametro `LATO` in `main.gd`) per renderlo più difficile.
- Sottomarino più "vero" (colori, luci), bolle d'acqua, suono dell'esplosione.
- Più sottomarini quando questo funziona bene.
