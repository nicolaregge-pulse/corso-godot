# Il Manuale — Corso di Godot 🎮

**Versione 0.1** — 26/07/2026
*Fonte versionata del manuale. Da questo file si genera il PDF da consegnare.*

> Come si legge questo manuale: è pensato per chi conosce già un po' **Lazarus**
> (bottoni, caselle di testo, la proprietà Caption). Ogni concetto nuovo lo
> agganciamo a qualcosa che già conosci.

---

## Capitolo 0 — Cos'è Godot (e com'è "parente" di Lazarus)

**Godot** è un programma gratuito per creare **giochi** e app interattive.
È molto simile, come spirito, a **Lazarus**: entrambi sono ambienti gratuiti
dove **componi qualcosa a schermo e ci attacchi del codice**.

La "stele di Rosetta" Lazarus → Godot:

| In Lazarus (lo sai) | In Godot (nuovo) |
|---|---|
| **Progetto** | **Progetto** (uguale) |
| **Form** (la finestra) | **Scena** (un *albero di nodi*, più potente) |
| **Componenti** (TButton, TEdit…) | **Nodi** (Button, LineEdit, Label…) |
| **Proprietà** (Caption…) nell'Object Inspector | **Proprietà** nell'**Ispettore** |
| **Gestore evento** (`Button1Click`) | **Segnale + funzione** |
| **Object Pascal** (il linguaggio) | **GDScript** (linguaggio, stile Python) |

**La differenza più importante — il "game loop":**
in Lazarus il programma è **fermo** finché non clicchi qualcosa. In Godot c'è
una funzione, `_process(delta)`, che **gira da sola ~60 volte al secondo**,
in continuazione. È questo che fa muovere le cose (personaggi, oggetti che
cadono, animazioni).

> 💡 In una frase: **Lazarus reagisce, Godot pulsa.**

---

### L'ambiente di sviluppo all'avvio

Quando apri un progetto nuovo, l'editor si presenta così: vista **3D** di
default e scena ancora vuota.

![L'editor di Godot appena aperto, con la scena vuota](immagini/AmbienteGodot.png)

> Per il nostro corso lavoreremo quasi sempre in **2D**: cliccheremo **"Scena
> 2D"** per iniziare (lo vediamo nel Capitolo 1).

---

## Capitolo 1 — I 4 concetti base di Godot

Se capisci questi quattro, capisci Godot:

| Concetto | Cos'è | Analogia LEGO |
|---|---|---|
| **Progetto** | La cartella con dentro il file `project.godot` e tutto il gioco | La scatola del set |
| **Nodo** | Il mattoncino base (Sprite2D = immagine, Label = testo, Timer = cronometro…) | Un pezzo di LEGO |
| **Scena** | Tanti nodi messi ad albero, salvati in un file `.tscn` | Una costruzione |
| **Script** (`.gd`) | Codice **GDScript** attaccato a un nodo, che gli dà comportamento | Le istruzioni |

**Regola d'oro:** in Godot **tutto è un nodo**; le scene sono nodi messi
insieme; gli script danno vita ai nodi.

---

## Capitolo 2 — GDScript: il linguaggio

GDScript è la lingua che si parla **dentro** Godot. È stato fatto apposta per
somigliare a **Python**: si legge facile, si usa il **rientro (TAB)** per
raggruppare le righe, **niente punto e virgola**.

Due funzioni speciali che Godot chiama da solo:
- `func _ready():` → eseguita **una volta**, all'avvio (per preparare le cose).
- `func _process(delta):` → eseguita **a ogni fotogramma** (il game loop).
  `delta` = secondi passati dall'ultimo fotogramma; serve a muoversi in modo
  fluido su qualsiasi PC.

Esempio minimo (leggere le frecce e spostare qualcosa):

```gdscript
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		posizione.x -= 200 * delta   # vai a sinistra
	if Input.is_action_pressed("ui_right"):
		posizione.x += 200 * delta   # vai a destra
```

---

## Capitolo 3 — Il nostro primo gioco: "Chirurgo Pasticcione"

**Idea:** un chirurgo maldestro fa cadere gli organi dal tavolo. Tu muovi il
**vassoio** con le frecce ← → e li prendi al volo.
- organo preso → **+1 punto**
- organo per terra → **-1 vita**
- zero vite → **Operazione Fallita** (INVIO per riprovare)

**Cosa ci insegna:**
- Creare nodi da codice (il vassoio, gli organi, le scritte).
- Il **movimento** con le frecce (input + `delta`).
- Le **collisioni** (quando il vassoio "tocca" un organo).
- Tenere lo **stato del gioco** (punti, vite) e mostrarlo a schermo.
- Un **Timer** che fa comparire gli organi a intervalli.

Il codice completo e commentato è in `godot/chirurgo-pasticcione/main.gd`.

---

## Come useremo l'AI (regola per i ragazzi)

L'AI è come la **calcolatrice in matematica**: aiuta, ma se non capisci cosa
stai facendo non serve a niente.
- ✅ Usala per: capire un errore, farti spiegare un concetto, avere un
  suggerimento, uno **spunto da studiare e modificare**.
- ❌ Non usarla per: farti scrivere tutto e consegnarlo senza capirlo.
- **Prova del nove:** se sai **spiegare a voce, riga per riga**, il codice che
  presenti, la competenza c'è.

---

## Changelog del manuale

| Versione | Data | Cosa è cambiato |
|---|---|---|
| 0.1 | 26/07/2026 | Prima stesura: Cap. 0 (Godot vs Lazarus), Cap. 1 (i 4 concetti), Cap. 2 (GDScript, game loop), Cap. 3 (Chirurgo Pasticcione), regola uso AI. |
