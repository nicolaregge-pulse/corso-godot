# Affonda la Bonomi 🌊💣 (battaglia navale 3D — prototipo)

Una battaglia navale **in tre dimensioni**: invece della solita griglia a righe
e colonne, c'è un **cubo** di celle d'acqua. Dentro è nascosto **un
sottomarino**. Lanci una **bomba di profondità** su una cella: esplode e colpisce
una zona **3×3×3** attorno al punto. Se il sottomarino è in quella zona → COLPITO!

> ⚠️ È una **prima bozza** fatta per Nicola, da provare e migliorare insieme
> (grafica, effetti, difficoltà). Non è ancora un esercizio per i ragazzi.

## All'avvio: scegli la difficoltà
Appena parte, il gioco chiede **quanti cubi per lato** vuoi: da **5** (facile) a
**10** (difficile). Più grande è il cubo, più celle e più nascondigli per il
sottomarino. Clicca un numero e la partita comincia.

## Coordinate di ogni cella
- **Colonna** = LETTERA MAIUSCOLA (A B C D E …)
- **Fila** = lettera minuscola (a b c d e …)
- **Profondità** = NUMERO (1 2 3 4 5 …)

Le lettere e i numeri sono scritti **attorno al cubo** per ritrovarti.

## Come si gioca (6 tasti + Shift)
Il **mirino** è la cella che brilla di verde. Lo muovi con **sei lettere**, a
coppie, ognuna del **colore del suo asse** (le vedi anche sulle frecce accanto al
cubo):
- **A / D** = **Colonna** (−/+) → lettere **rosse**
- **W / S** = **Fila** (+/−) → lettere **verdi**
- **Q / E** = **Profondità** (−/+) → lettere **gialle**
- **SHIFT + le stesse lettere** = **girano il cubo** invece di muovere il mirino
  (così bastano 6 tasti: lo Shift attiva/disattiva la rotazione).
- **Mouse trascinato** = gira il cubo (in più, se vuoi).
- **SPAZIO** = lancia la bomba di profondità sulla cella del mirino (zona 3×3×3).
- **INVIO** = nuova partita (nuovo sottomarino nascosto).

## Quando colpisci 💥
Se la bomba prende il sottomarino, esplode e compare a tutto schermo la faccia
di **Serena** con 🔥 💀 🔥 che **lampeggia**; poi l'overlay sparisce e si vede il
**sottomarino affondato** (inclinato). Per far comparire la foto basta mettere un
file **`serena.jpg`** nella cartella `battaglia-navale-3d/` (se non c'è, restano
solo le emoji del fuoco e del teschio).

## Sul telefono/tablet (touch)
In basso a sinistra ci sono **tre coppie +/- colorate**, una per asse (come le
coordinate): **Colonna** (rosso), **Fila** (verde), **Profondità** (giallo) → così
sai sempre quale asse muovi. Le **tre frecce colorate** accanto al cubo mostrano
le direzioni degli assi (con su scritte le lettere-tasto) e girano insieme al
cubo. Il **💣** grande in basso a destra lancia la bomba, il **↻** rigioca. Per
**girare il cubo** trascini il **dito**.

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
- Sottomarino più "vero" (colori, luci), bolle d'acqua, suono dell'esplosione.
- Più sottomarini quando questo funziona bene.
- Un contatore dei tentativi migliori (record) e magari un timer.
