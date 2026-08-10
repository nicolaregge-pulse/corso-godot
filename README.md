# Corso Godot

Il corso di **Godot** e **GDScript** per i ragazzi.

Per l'elenco completo e aggiornato di tutto il materiale, vedi
**[INDICE-DEL-MATERIALE.md](INDICE-DEL-MATERIALE.md)**: manuale, esercizi, giochi,
kit di consegna e altro.

---

## Concetti base di Godot (il modello mentale)

Godot organizza tutto con **4 concetti**. Se capisci questi, capisci Godot:

| Concetto | Cos'è | Analogia |
|---|---|---|
| **Progetto** | Una cartella con dentro un file `project.godot` + tutti i file del gioco | La "cartella del gioco" |
| **Nodo** (Node) | Il mattoncino base. Ne esistono di tanti tipi: `Sprite2D` (immagine), `Label` (testo), `Timer` (cronometro), `Node2D` (contenitore 2D)… | Un pezzo di LEGO |
| **Scena** (Scene) | Un albero di nodi salvato in un file `.tscn`. Un livello, un menu, un personaggio… | Una costruzione di LEGO |
| **Script** (`.gd`) | Codice **GDScript** attaccato a un nodo, che gli dà comportamento | Le istruzioni "cosa fai quando…" |

**Regola d'oro:** in Godot **tutto è un nodo**, le scene sono nodi messi
insieme ad albero, e gli script danno vita ai nodi.

### GDScript in 30 secondi
GDScript è il linguaggio di Godot: assomiglia molto a **Python**
(indentazione a TAB, niente punto e virgola). Due funzioni speciali che
Godot chiama da solo:
- `func _ready():` → eseguita **una volta**, quando il nodo entra in scena.
- `func _process(delta):` → eseguita **a ogni fotogramma** (~60 volte/sec).
  `delta` = secondi passati dall'ultimo fotogramma.

### Serve un plugin per iniziare?
**No.** GDScript, l'editor di codice, il 2D e il 3D sono **già dentro
Godot**. I plugin servono dopo, per esigenze specifiche. Per imparare: zero
plugin.

---

## Progetti in questa cartella

### `chirurgo-pasticcione/` — il primo gioco
Primo gioco costruito da zero il 23/07/2026. Il chirurgo maldestro fa cadere
gli organi dal tavolo: muovi il **vassoio** con le frecce ← → e prendili al
volo. Presa = +1 punto; organo a terra = -1 vita; a zero vite "Operazione
Fallita" (INVIO per riprovare). Tutto in un unico script: `main.gd`.

Questa è una **copia di backup**: il progetto "vivo" su cui lavoro è in
`C:\Godot\Il mio primo gioco` sul PC.

Idee per i prossimi passi: suoni buffi, un "bisturi" da NON prendere,
punteggio record, difficoltà che cresce.

### `acchiappa-le-stelle/`
Mini gioco completo di esempio: muovi una navetta con le frecce e prendi le
stelle che cadono. Tutto in un unico script commentato: `main.gd`.

**Come aprirlo in Godot (sul tuo PC Windows):**
1. Apri **Godot**.
2. In alto scegli la scheda **Progetti** → pulsante **Importa**.
3. Naviga fino a questa cartella `godot/acchiappa-le-stelle/` e seleziona il
   file **`project.godot`**.
4. Premi **Importa e modifica**.
5. In alto a destra premi il tasto **▶ Esegui** (o `F5`).

File del progetto:
- `project.godot` → configurazione (nome, scena iniziale, dimensione finestra)
- `main.tscn` → la scena principale (un nodo `Node2D` con lo script attaccato)
- `main.gd` → tutto il codice del gioco, commentato in italiano
