extends Node2D
# GIOCO — Torta in faccia.
# Lancia con una STRISCIATA del dito: conta la VELOCITA' e la DIREZIONE del
# gesto, come tirare davvero. Strisciata veloce = tiro forte. Niente mira
# assistita: tiri a sentimento. Punti secondo quanto sei vicino al centro.
#
# LA FACCIA: e' il file sfondo.png (la foto a tutto schermo).

# ===== FALLO TUO =====
const TIRI_TOTALI: int = 5
const FORZA_TIRO: float = 1.0        # moltiplica la velocita' della strisciata
const TIRO_MAX: float = 2300.0       # velocita' massima del tiro
const GRAVITA: float = 1500.0
# =====================

@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var campo: Node2D
var faccia: Sprite2D
var bersaglio: Sprite2D
var torta: Sprite2D
var splats: Array = []
var centro: Vector2
var half: float
var r100: float
var r50: float
var r25: float
var r10: float
var ancora: Vector2
var torta_v: Vector2 = Vector2.ZERO
var pronto: bool = true
var in_volo: bool = false
var puntando: bool = false
var storia: Array = []               # posizioni recenti del dito, per la velocita'
var vicino: float = 999999.0
var vicino_pos: Vector2 = Vector2.ZERO
var entrato: bool = false
var tiri: int = 0
var punti: int = 0
var pausa: float = 0.0
var vp: Vector2

func _ready() -> void:
	vp = get_viewport_rect().size
	campo = Node2D.new()
	add_child(campo)
	move_child(campo, 0)
	var sfondo_tex: Texture2D = load("res://sfondo.png")
	var bersaglio_tex: Texture2D = load("res://bersaglio.png")
	centro = Vector2(vp.x * 0.5, vp.y * 0.505)
	half = 290.0
	r100 = 0.258 * half
	r50 = 0.50 * half
	r25 = 0.742 * half
	r10 = 0.96 * half
	faccia = Sprite2D.new()
	faccia.texture = sfondo_tex
	faccia.position = Vector2(vp.x * 0.5, vp.y * 0.5)
	campo.add_child(faccia)
	bersaglio = Sprite2D.new()
	bersaglio.texture = bersaglio_tex
	bersaglio.position = centro
	var bsc: float = (2.0 * half) / float(bersaglio_tex.get_width())
	bersaglio.scale = Vector2(bsc, bsc)
	campo.add_child(bersaglio)
	torta = Sprite2D.new()
	var torta_tex: Texture2D = load("res://torta.png")
	torta.texture = torta_tex
	torta.scale = Vector2(100.0 / float(torta_tex.get_width()), 100.0 / float(torta_tex.get_height()))
	ancora = Vector2(vp.x * 0.5, vp.y - 120.0)
	torta.position = ancora
	campo.add_child(torta)
	hudVar.position = Vector2(24, 24)
	hudVar.add_theme_font_size_override("font_size", 30)
	gameoverVar.add_theme_font_size_override("font_size", 40)
	gameoverVar.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gameoverVar.size = Vector2(400, 90)
	gameoverVar.position = Vector2(vp.x / 2.0 - 200.0, vp.y * 0.80)
	gameoverVar.visible = false
	rigiocaVar.focus_mode = Control.FOCUS_NONE
	rigiocaVar.add_theme_font_size_override("font_size", 30)
	rigiocaVar.size = Vector2(200, 60)
	rigiocaVar.position = Vector2(vp.x / 2.0 - 100.0, vp.y * 0.80 + 100.0)
	rigiocaVar.pressed.connect(_ricomincia)
	rigiocaVar.visible = false
	_aggiorna_hud()

func _input(event: InputEvent) -> void:
	if not pronto or in_volo:
		return
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			puntando = true
			storia = [[event.position, Time.get_ticks_msec()]]
		else:
			if puntando:
				puntando = false
				_lancia()
	elif (event is InputEventScreenDrag or event is InputEventMouseMotion) and puntando:
		storia.append([event.position, Time.get_ticks_msec()])
		if storia.size() > 8:
			storia.pop_front()

func _velocita_strisciata() -> Vector2:
	if storia.size() < 2:
		return Vector2.ZERO
	var ultimo: Array = storia[storia.size() - 1]
	var primo: Array = storia[0]
	# prendi il tratto negli ultimi ~130 ms per catturare il "colpo" finale
	for e in storia:
		if ultimo[1] - e[1] <= 130:
			primo = e
			break
	var dt: float = float(ultimo[1] - primo[1]) / 1000.0
	if dt < 0.001:
		return Vector2.ZERO
	return (ultimo[0] - primo[0]) / dt

func _lancia() -> void:
	var v: Vector2 = _velocita_strisciata() * FORZA_TIRO
	if v.length() < 200.0:            # strisciata troppo lenta: non lancia
		return
	if v.length() > TIRO_MAX:
		v = v.normalized() * TIRO_MAX
	torta.position = ancora
	torta_v = v
	in_volo = true
	pronto = false
	vicino = 999999.0
	entrato = false

func _process(delta: float) -> void:
	if tiri >= TIRI_TOTALI and not in_volo:
		if Input.is_action_just_pressed("ui_accept"):
			_ricomincia()
		return
	if not pronto and not in_volo and pausa > 0.0:
		pausa -= delta
		if pausa <= 0.0 and tiri < TIRI_TOTALI:
			_rimetti()
	if in_volo:
		_vola(delta)

func _vola(delta: float) -> void:
	torta_v.y += GRAVITA * delta
	torta.position += torta_v * delta
	torta.rotation += delta * 10.0
	var d: float = torta.position.distance_to(centro)
	if d < vicino:
		vicino = d
		vicino_pos = torta.position
	if d <= r10:
		entrato = true
	if entrato and d > r10:
		_colpito(vicino_pos, vicino)
	elif torta.position.y > vp.y + 150.0 or torta.position.x < -150.0 or torta.position.x > vp.x + 150.0:
		if entrato:
			_colpito(vicino_pos, vicino)
		else:
			_mancato()

func _colpito(pos: Vector2, d: float) -> void:
	var p: int = 10
	if d <= r100:
		p = 100
	elif d <= r50:
		p = 50
	elif d <= r25:
		p = 25
	punti += p
	_splat(pos)
	_mostra_scritta(pos, "+" + str(p))
	_fine_tiro()

func _mancato() -> void:
	_mostra_scritta(centro + Vector2(-90, 0), "MANCATO")
	_fine_tiro()

func _fine_tiro() -> void:
	in_volo = false
	torta.visible = false
	tiri += 1
	_aggiorna_hud()
	if tiri >= TIRI_TOTALI:
		_fine()
	else:
		pausa = 0.5

func _rimetti() -> void:
	torta.position = ancora
	torta.rotation = 0.0
	torta.visible = true
	torta_v = Vector2.ZERO
	pronto = true

func _splat(pos: Vector2) -> void:
	var s: Sprite2D = Sprite2D.new()
	var tex: Texture2D = load("res://splat.png")
	s.texture = tex
	s.scale = Vector2(130.0 / float(tex.get_width()), 130.0 / float(tex.get_height()))
	s.position = pos
	campo.add_child(s)
	splats.append(s)

func _mostra_scritta(pos: Vector2, txt: String) -> void:
	var l: Label = Label.new()
	l.text = txt
	l.add_theme_font_size_override("font_size", 46)
	l.position = pos - Vector2(40, 30)
	add_child(l)
	var tw: Tween = create_tween().set_parallel(true)
	tw.tween_property(l, "position:y", l.position.y - 80.0, 0.7)
	tw.tween_property(l, "modulate:a", 0.0, 0.7).from(1.0)
	tw.chain().tween_callback(l.queue_free)

func _fine() -> void:
	gameoverVar.text = "FINITO!\nPunti: %d" % punti
	gameoverVar.visible = true
	gameoverVar.move_to_front()
	rigiocaVar.visible = true
	rigiocaVar.move_to_front()

func _ricomincia() -> void:
	for s in splats:
		s.queue_free()
	splats.clear()
	punti = 0
	tiri = 0
	in_volo = false
	pronto = true
	puntando = false
	pausa = 0.0
	storia = []
	torta.position = ancora
	torta.rotation = 0.0
	torta.visible = true
	torta_v = Vector2.ZERO
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Tiri: %d/%d    Punti: %d" % [tiri, TIRI_TOTALI, punti]
