extends Node2D
# ESERCIZIO 4 — Acchiappa le stelle (soluzione funzionante).
# Concetto NUOVO: le VITE e il GAME OVER. Il gioco ora si puo' PERDERE e FINIRE.
# E' l'Esercizio 3 che cresce: prendi le stelle, ma se ne perdi troppe e' finita.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

@onready var navettaVar: ColorRect = $navettaScena
@onready var stellaVar: ColorRect = $stellaScena
@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena

const VELOCITA_NAVETTA: float = 500.0
const VELOCITA_STELLA: float = 300.0
const VITE_INIZIALI: int = 3

var punti: int = 0
var vite: int = VITE_INIZIALI
var in_gioco: bool = true
var larghezza: float

func _ready() -> void:
	larghezza = get_viewport_rect().size.x
	# La navetta in basso
	navettaVar.size = Vector2(90, 20)
	navettaVar.color = Color(0.3, 0.7, 1.0)   # azzurro
	navettaVar.position = Vector2(larghezza / 2.0 - 45, get_viewport_rect().size.y - 50)
	# La stella
	stellaVar.size = Vector2(28, 28)
	stellaVar.color = Color(1.0, 0.85, 0.2)   # giallo
	# Il punteggio e le vite
	hudVar.position = Vector2(20, 20)
	# La scritta di fine partita (nascosta all'inizio)
	gameoverVar.position = Vector2(larghezza / 2.0 - 140, get_viewport_rect().size.y / 2.0 - 20)
	gameoverVar.text = "GAME OVER\nPremi INVIO per ricominciare"
	gameoverVar.visible = false
	_rimetti_in_alto()
	_aggiorna_hud()

func _process(delta: float) -> void:
	# Se la partita e' finita: aspetta INVIO per ricominciare, e basta.
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):   # INVIO / Spazio
			_ricomincia()
		return

	# Muovi la navetta con le frecce
	if Input.is_action_pressed("ui_left"):
		navettaVar.position.x -= VELOCITA_NAVETTA * delta
	if Input.is_action_pressed("ui_right"):
		navettaVar.position.x += VELOCITA_NAVETTA * delta
	navettaVar.position.x = clamp(navettaVar.position.x, 0, larghezza - navettaVar.size.x)

	# Fai scendere la stella
	stellaVar.position.y += VELOCITA_STELLA * delta

	# Presa?
	if Rect2(navettaVar.position, navettaVar.size).intersects(Rect2(stellaVar.position, stellaVar.size)):
		punti += 1
		_aggiorna_hud()
		_rimetti_in_alto()
	# Persa (uscita sotto)? -> togli una vita
	elif stellaVar.position.y > get_viewport_rect().size.y:
		vite -= 1
		_aggiorna_hud()
		_rimetti_in_alto()
		if vite <= 0:
			_game_over()

func _rimetti_in_alto() -> void:
	var x := randf_range(0, larghezza - stellaVar.size.x)
	stellaVar.position = Vector2(x, -stellaVar.size.y)

func _game_over() -> void:
	in_gioco = false
	gameoverVar.visible = true

func _ricomincia() -> void:
	punti = 0
	vite = VITE_INIZIALI
	in_gioco = true
	gameoverVar.visible = false
	_rimetti_in_alto()
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Punti: %d    Vite: %d" % [punti, vite]
