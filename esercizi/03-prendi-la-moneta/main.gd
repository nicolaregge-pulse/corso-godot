extends Node2D
# ESERCIZIO 3 — Prendi la moneta (soluzione funzionante).
# Mette insieme: movimento + oggetto che cade + punteggio. Verso il gioco vero.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

@onready var cestinoVar: ColorRect = $cestinoScena
@onready var monetaVar: ColorRect = $monetaScena
@onready var punteggioVar: Label = $punteggioScena

const VELOCITA_CESTINO: float = 500.0
const VELOCITA_MONETA: float = 300.0

var punti: int = 0
var larghezza: float

func _ready() -> void:
	larghezza = get_viewport_rect().size.x
	# Cestino in basso
	cestinoVar.size = Vector2(120, 24)
	cestinoVar.color = Color(0.6, 0.4, 0.2)
	cestinoVar.position = Vector2(larghezza / 2.0 - 60, get_viewport_rect().size.y - 60)
	# Moneta
	monetaVar.size = Vector2(30, 30)
	monetaVar.color = Color(1.0, 0.85, 0.1)
	_rimetti_in_alto()
	# Punteggio
	punteggioVar.position = Vector2(20, 20)
	_aggiorna_punteggio()

func _process(delta: float) -> void:
	# Muovi il cestino
	if Input.is_action_pressed("ui_left"):
		cestinoVar.position.x -= VELOCITA_CESTINO * delta
	if Input.is_action_pressed("ui_right"):
		cestinoVar.position.x += VELOCITA_CESTINO * delta
	cestinoVar.position.x = clamp(cestinoVar.position.x, 0, larghezza - cestinoVar.size.x)

	# Fai scendere la moneta
	monetaVar.position.y += VELOCITA_MONETA * delta

	# Presa?
	if Rect2(cestinoVar.position, cestinoVar.size).intersects(Rect2(monetaVar.position, monetaVar.size)):
		punti += 1
		_aggiorna_punteggio()
		_rimetti_in_alto()
	# Persa, uscita sotto?
	elif monetaVar.position.y > get_viewport_rect().size.y:
		_rimetti_in_alto()

func _rimetti_in_alto() -> void:
	var x := randf_range(0, larghezza - monetaVar.size.x)
	monetaVar.position = Vector2(x, -monetaVar.size.y)

func _aggiorna_punteggio() -> void:
	punteggioVar.text = "Monete: %d" % punti
