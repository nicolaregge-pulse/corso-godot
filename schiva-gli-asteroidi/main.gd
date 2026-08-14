extends Node2D
# GIOCO — Schiva gli asteroidi.
# Muovi la navetta con il dito o con le frecce e schiva i sassi che cadono.
# Piu' resisti, piu' alto il punteggio. Col tempo diventa piu' difficile.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

# ===== FALLO TUO: cambia velocita', ritmo e colori =====
const VELOCITA_NAVETTA: float = 700.0
const VELOCITA_ASTEROIDI: float = 260.0
const OGNI_QUANTO: float = 0.85         # ogni quanti secondi cade un sasso
const COLORE_NAVETTA: Color = Color(0.30, 0.80, 1.0)
const COLORE_ASTEROIDE: Color = Color(0.70, 0.40, 0.30)
# =======================================================

@onready var navettaVar: ColorRect = $navettaScena
@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var asteroidi: Array = []
var tempo: float = 0.0
var spawn_timer: float = 0.0
var in_gioco: bool = true
var larghezza: float
var altezza: float

func _ready() -> void:
	larghezza = get_viewport_rect().size.x
	altezza = get_viewport_rect().size.y
	navettaVar.size = Vector2(90, 26)
	navettaVar.color = COLORE_NAVETTA
	navettaVar.position = Vector2(larghezza / 2.0 - 45.0, altezza - 90.0)
	hudVar.position = Vector2(24, 24)
	hudVar.add_theme_font_size_override("font_size", 30)
	gameoverVar.add_theme_font_size_override("font_size", 40)
	gameoverVar.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gameoverVar.size = Vector2(360, 90)
	gameoverVar.position = Vector2(larghezza / 2.0 - 180.0, altezza * 0.34)
	gameoverVar.visible = false
	rigiocaVar.focus_mode = Control.FOCUS_NONE
	rigiocaVar.add_theme_font_size_override("font_size", 30)
	rigiocaVar.size = Vector2(200, 60)
	rigiocaVar.position = Vector2(larghezza / 2.0 - 100.0, altezza * 0.34 + 110.0)
	rigiocaVar.pressed.connect(_ricomincia)
	rigiocaVar.visible = false
	_aggiorna_hud()

func _process(delta: float) -> void:
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):
			_ricomincia()
		return
	tempo += delta

	# Muovi la navetta: frecce oppure dito/mouse tenuto premuto
	if Input.is_action_pressed("ui_left"):
		navettaVar.position.x -= VELOCITA_NAVETTA * delta
	elif Input.is_action_pressed("ui_right"):
		navettaVar.position.x += VELOCITA_NAVETTA * delta
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		navettaVar.position.x = get_viewport().get_mouse_position().x - navettaVar.size.x / 2.0
	navettaVar.position.x = clamp(navettaVar.position.x, 0.0, larghezza - navettaVar.size.x)

	# Fai comparire nuovi asteroidi, sempre piu' spesso
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		_crea_asteroide()
		spawn_timer = max(0.35, OGNI_QUANTO - tempo * 0.02)

	# Falli scendere, sempre piu' veloci
	var vel: float = VELOCITA_ASTEROIDI + tempo * 6.0
	var navetta_rect: Rect2 = Rect2(navettaVar.position, navettaVar.size)
	for a in asteroidi.duplicate():
		a.position.y += vel * delta
		if Rect2(a.position, a.size).intersects(navetta_rect):
			_game_over()
			return
		if a.position.y > altezza:
			a.queue_free()
			asteroidi.erase(a)

	_aggiorna_hud()

func _crea_asteroide() -> void:
	var a: ColorRect = ColorRect.new()
	var lato: float = randf_range(30.0, 66.0)
	a.size = Vector2(lato, lato)
	a.color = COLORE_ASTEROIDE
	a.position = Vector2(randf_range(0.0, larghezza - lato), -lato)
	add_child(a)
	asteroidi.append(a)

func _game_over() -> void:
	in_gioco = false
	gameoverVar.text = "COLPITO!\nSei durato %d secondi" % int(tempo)
	gameoverVar.visible = true
	gameoverVar.move_to_front()
	rigiocaVar.visible = true
	rigiocaVar.move_to_front()

func _ricomincia() -> void:
	for a in asteroidi:
		a.queue_free()
	asteroidi.clear()
	tempo = 0.0
	spawn_timer = 0.0
	in_gioco = true
	navettaVar.position = Vector2(larghezza / 2.0 - navettaVar.size.x / 2.0, altezza - 90.0)
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Tempo: %d" % int(tempo)
