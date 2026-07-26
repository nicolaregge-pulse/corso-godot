# Battaglia Navale 3D 🌊💣 (prototipo)

Una battaglia navale **in tre dimensioni**: invece della solita griglia a righe
e colonne, c'è un **cubo** di celle d'acqua. Dentro è nascosto **un
sottomarino**. Lanci una **bomba di profondità** su una cella: esplode e colpisce
una zona **3×3×3** attorno al punto. Se il sottomarino è in quella zona → COLPITO!

> ⚠️ È una **prima bozza** fatta per Nicola, da provare e migliorare insieme
> (grafica, effetti, difficoltà). Non è ancora un esercizio per i ragazzi.

## Coordinate di ogni cella
- **Colonna** = LETTERA MAIUSCOLA (A B C D E)
- **Fila** = lettera minuscola (a b c d e)
- **Profondità** = NUMERO (1 2 3 4 5)

Le lettere e i numeri sono scritti **attorno al cubo** per ritrovarti.

## Come si gioca (6 tasti + Shift)
- **Frecce ← → ↑ ↓** = muovi il **mirino** (la cella che brilla di verde) su colonna e fila.
- **Q / A** = muovi il mirino in profondità.
- **SHIFT + gli stessi tasti** (frecce e Q/A) = **girano il cubo** invece di muovere il mirino.
- **Mouse trascinato** = gira il cubo (in più, se vuoi).
- **SPAZIO** = lancia la bomba di profondità sulla cella del mirino (zona 3×3×3).
- **INVIO** = nuova partita (nuovo sottomarino nascosto).

## Sul telefono/tablet (touch)
Ci sono i **pulsanti a schermo**: il joypad in basso a sinistra (mirino), i tasti
**Prof−/Prof+** per la profondità, il **💣** per la bomba, il **↻** per rigiocare.
Per **girare il cubo** trascini il **dito** sullo schermo.

## Come portarlo sul telefono (via Web, senza installare niente)
1. `[APP — Godot]` menù **`Progetto` → `Esporta…`**.
2. **`Aggiungi…` → `Web`**. Se chiede i *modelli di esportazione*, clicca per
   **scaricarli** (una volta sola).
3. **`Esporta progetto`** → scegli una cartella (es. `web/`) e come nome file
   **`index.html`** → esporta.
4. Quei file vanno messi **online**: la via più semplice e browser-only è
   **GitHub Pages** (Impostazioni del repo → *Pages*). Poi apri il **link** sul
   telefono. → Nessuna installazione, giochi dal browser e puoi condividerlo.

Quando punti una cella, la sua **tripletta di coordinate** (attorno al cubo) diventa **grande e bianca**, così vedi subito cosa hai selezionato.

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
