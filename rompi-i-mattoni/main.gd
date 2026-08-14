extends Node2D
# GIOCO — Rompi i mattoni.
# Muovi la racchetta in basso (dito o frecce), fai rimbalzare la pallina e
# spacca tutti i mattoni. Se la pallina cade sotto, perdi una vita.

# ===== FALLO TUO: cambia velocita', numero di mattoni e colori =====
const VELOCITA_PALLA: float = 480.0
const VELOCITA_RACCHETTA: float = 720.0
const RIGHE: int = 5
const COLONNE: int = 8
const VITE_INIZIALI: int = 3
const COLORE_RACCHETTA: Color = Color(0.35, 0.85, 1.0)
const COLORE_PALLA: Color = Color(1.0, 0.95, 0.7)
const COLORI_MATTONI: Array = [
	Color(0.90, 0.30, 0.30), Color(0.95, 0.60, 0.25), Color(0.95, 0.85, 0.30),
	Color(0.45, 0.80, 0.40), Color(0.45, 0.65, 0.95)
]
# ===================================================================

@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var campo: Node2D
var racchetta: ColorRect
var palla: ColorRect
var mattoni: Array = []
var palla_v: Vector2 = Vector2.ZERO
var punti: int = 0
var vite: int = VITE_INIZIALI
var in_gioco: bool = true
var vp: Vector2
var lato_palla: float = 22.0

func _ready() -> void:
	vp = get_viewport_rect().size
	campo = Node2D.new()
	add_child(campo)
	move_child(campo, 0)
	_crea_racchetta()
	_crea_palla()
	_crea_mattoni()
	hudVar.position = Vector2(24, 24)
	hudVar.add_theme_font_size_override("font_size", 30)
	gameoverVar.add_theme_font_size_override("font_size", 40)
	gameoverVar.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gameoverVar.size = Vector2(400, 90)
	gameoverVar.position = Vector2(vp.x / 2.0 - 200.0, vp.y * 0.34)
	gameoverVar.visible = false
	rigiocaVar.focus_mode = Control.FOCUS_NONE
	rigiocaVar.add_theme_font_size_override("font_size", 30)
	rigiocaVar.size = Vector2(200, 60)
	rigiocaVar.position = Vector2(vp.x / 2.0 - 100.0, vp.y * 0.34 + 110.0)
	rigiocaVar.pressed.connect(_ricomincia)
	rigiocaVar.visible = false
	_rimetti_palla()
	_aggiorna_hud()

func _crea_racchetta() -> void:
	racchetta = ColorRect.new()
	racchetta.size = Vector2(150, 22)
	racchetta.color = COLORE_RACCHETTA
	racchetta.position = Vector2(vp.x / 2.0 - 75.0, vp.y - 100.0)
	campo.add_child(racchetta)

func _crea_palla() -> void:
	palla = ColorRect.new()
	palla.size = Vector2(lato_palla, lato_palla)
	palla.color = COLORE_PALLA
	campo.add_child(palla)

func _crea_mattoni() -> void:
	var margine: float = 30.0
	var top: float = 120.0
	var gap: float = 8.0
	var larghezza: float = (vp.x - margine * 2.0 - gap * float(COLONNE - 1)) / float(COLONNE)
	var altezza: float = 34.0
	for r in RIGHE:
		for c in COLONNE:
			var m: ColorRect = ColorRect.new()
			m.size = Vector2(larghezza, altezza)
			m.position = Vector2(margine + c * (larghezza + gap), top + r * (altezza + gap))
			m.color = COLORI_MATTONI[r % COLORI_MATTONI.size()]
			campo.add_child(m)
			mattoni.append(m)

func _rimetti_palla() -> void:
	palla.position = Vector2(racchetta.position.x + racchetta.size.x / 2.0 - lato_palla / 2.0, racchetta.position.y - lato_palla - 4.0)
	palla_v = Vector2(0.35, -1.0).normalized() * VELOCITA_PALLA

func _process(delta: float) -> void:
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):
			_ricomincia()
		return
	_muovi_racchetta(delta)
	_muovi_palla(delta)

func _muovi_racchetta(delta: float) -> void:
	var dx: float = 0.0
	if Input.is_action_pressed("ui_left"):
		dx -= 1.0
	if Input.is_action_pressed("ui_right"):
		dx += 1.0
	if dx != 0.0:
		racchetta.position.x += dx * VELOCITA_RACCHETTA * delta
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		racchetta.position.x = get_viewport().get_mouse_position().x - racchetta.size.x / 2.0
	racchetta.position.x = clamp(racchetta.position.x, 0.0, vp.x - racchetta.size.x)

func _muovi_palla(delta: float) -> void:
	palla.position += palla_v * delta
	# muri laterali
	if palla.position.x <= 0.0:
		palla.position.x = 0.0
		palla_v.x = abs(palla_v.x)
	elif palla.position.x + lato_palla >= vp.x:
		palla.position.x = vp.x - lato_palla
		palla_v.x = -abs(palla_v.x)
	# soffitto
	if palla.position.y <= 0.0:
		palla.position.y = 0.0
		palla_v.y = abs(palla_v.y)
	# caduta sotto: perdi una vita
	if palla.position.y > vp.y:
		vite -= 1
		_aggiorna_hud()
		if vite <= 0:
			_game_over()
		else:
			_rimetti_palla()
		return
	# rimbalzo sulla racchetta, con angolo secondo dove la colpisci
	var pr: Rect2 = Rect2(palla.position, palla.size)
	var rr: Rect2 = Rect2(racchetta.position, racchetta.size)
	if palla_v.y > 0.0 and pr.intersects(rr):
		var offset: float = ((palla.position.x + lato_palla / 2.0) - (racchetta.position.x + racchetta.size.x / 2.0)) / (racchetta.size.x / 2.0)
		offset = clamp(offset, -1.0, 1.0)
		palla_v = Vector2(offset, -1.0).normalized() * VELOCITA_PALLA
		palla.position.y = racchetta.position.y - lato_palla - 1.0
		return
	# mattoni
	for m in mattoni:
		var mr: Rect2 = Rect2(m.position, m.size)
		if pr.intersects(mr):
			var ox: float = min(pr.position.x + pr.size.x, mr.position.x + mr.size.x) - max(pr.position.x, mr.position.x)
			var oy: float = min(pr.position.y + pr.size.y, mr.position.y + mr.size.y) - max(pr.position.y, mr.position.y)
			if ox < oy:
				palla_v.x = -palla_v.x
			else:
				palla_v.y = -palla_v.y
			mattoni.erase(m)
			m.queue_free()
			punti += 1
			_aggiorna_hud()
			if mattoni.is_empty():
				_vittoria()
			break

func _game_over() -> void:
	in_gioco = false
	gameoverVar.text = "GAME OVER\nPunti: %d" % punti
	gameoverVar.visible = true
	gameoverVar.move_to_front()
	rigiocaVar.visible = true
	rigiocaVar.move_to_front()

func _vittoria() -> void:
	in_gioco = false
	gameoverVar.text = "HAI VINTO!\nPunti: %d" % punti
	gameoverVar.visible = true
	gameoverVar.move_to_front()
	rigiocaVar.visible = true
	rigiocaVar.move_to_front()

func _ricomincia() -> void:
	for m in mattoni:
		m.queue_free()
	mattoni.clear()
	punti = 0
	vite = VITE_INIZIALI
	in_gioco = true
	racchetta.position.x = vp.x / 2.0 - racchetta.size.x / 2.0
	_crea_mattoni()
	_rimetti_palla()
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Punti: %d    Vite: %d" % [punti, vite]
