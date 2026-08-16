extends Node2D
# GIOCO — Schiva gli asteroidi.
# Sei un'astronave a triangolo, al centro dello schermo. Muoviti in tutte le
# direzioni con il dito o con le frecce, in tutto il campo, e schiva gli
# asteroidi che arrivano da ogni lato. Piu' resisti, piu' alto il punteggio.

# ===== FALLO TUO: cambia velocita', ritmo e colori =====
const VELOCITA_NAVE: float = 520.0
const VELOCITA_ASTEROIDI_MIN: float = 150.0
const VELOCITA_ASTEROIDI_MAX: float = 260.0
const OGNI_QUANTO: float = 0.9          # ogni quanti secondi arriva un asteroide
const COLORE_NAVE: Color = Color(0.35, 0.85, 1.0)
const COLORE_ASTEROIDE: Color = Color(0.72, 0.45, 0.34)
const RAGGIO_NAVE: float = 22.0         # quanto e' "grossa" la nave per gli scontri
# =======================================================

@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var campo: Node2D
var nave: Polygon2D
var asteroidi: Array = []
var tempo: float = 0.0
var spawn_timer: float = 0.0
var in_gioco: bool = true
var vp: Vector2
var angolo: float = -PI / 2.0
var suonoBoomVar: AudioStreamPlayer
var clas: CanvasLayer

func _ready() -> void:
	vp = get_viewport_rect().size
	# un contenitore per nave e asteroidi, messo DIETRO le scritte
	campo = Node2D.new()
	add_child(campo)
	move_child(campo, 0)
	_crea_nave()
	# il boom quando vieni colpito
	suonoBoomVar = AudioStreamPlayer.new()
	suonoBoomVar.stream = load("res://boom.wav")
	add_child(suonoBoomVar)
	clas = preload("res://classifica.gd").new()
	clas.gioco = "asteroidi"
	clas.etichetta = "secondi"
	clas.al_rigioco = _ricomincia
	add_child(clas)
	hudVar.position = Vector2(24, 24)
	hudVar.add_theme_font_size_override("font_size", 30)
	gameoverVar.add_theme_font_size_override("font_size", 40)
	gameoverVar.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gameoverVar.size = Vector2(360, 90)
	gameoverVar.position = Vector2(vp.x / 2.0 - 180.0, vp.y * 0.34)
	gameoverVar.visible = false
	rigiocaVar.focus_mode = Control.FOCUS_NONE
	rigiocaVar.add_theme_font_size_override("font_size", 30)
	rigiocaVar.size = Vector2(200, 60)
	rigiocaVar.position = Vector2(vp.x / 2.0 - 100.0, vp.y * 0.34 + 110.0)
	rigiocaVar.pressed.connect(_ricomincia)
	rigiocaVar.visible = false
	spawn_timer = 0.8
	_aggiorna_hud()

func _crea_nave() -> void:
	nave = Polygon2D.new()
	# triangolo che punta verso destra (angolo 0); lo ruotiamo con "angolo"
	nave.polygon = PackedVector2Array([Vector2(24, 0), Vector2(-16, -15), Vector2(-16, 15)])
	nave.color = COLORE_NAVE
	nave.position = vp / 2.0
	nave.rotation = angolo
	campo.add_child(nave)

func _process(delta: float) -> void:
	if not in_gioco:
		if clas.aperta:
			return
		if Input.is_action_just_pressed("ui_accept"):
			_ricomincia()
		return
	tempo += delta
	_muovi_nave(delta)
	_spawn(delta)
	_muovi_asteroidi(delta)
	_aggiorna_hud()

func _muovi_nave(delta: float) -> void:
	var dir: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		dir.x += 1.0
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1.0
	if Input.is_action_pressed("ui_down"):
		dir.y += 1.0
	# se non uso le frecce e tengo premuto il dito/mouse: la nave segue il dito
	if dir == Vector2.ZERO and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var verso: Vector2 = get_viewport().get_mouse_position() - nave.position
		if verso.length() > 8.0:
			dir = verso.normalized()
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		nave.position += dir * VELOCITA_NAVE * delta
		angolo = dir.angle()
	nave.position.x = clamp(nave.position.x, 0.0, vp.x)
	nave.position.y = clamp(nave.position.y, 0.0, vp.y)
	nave.rotation = angolo

func _spawn(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		_crea_asteroide()
		spawn_timer = max(0.35, OGNI_QUANTO - tempo * 0.02)

func _crea_asteroide() -> void:
	var lato: float = randf_range(26.0, 60.0)
	var h: float = lato / 2.0
	var a: Polygon2D = Polygon2D.new()
	a.polygon = PackedVector2Array([Vector2(-h, -h), Vector2(h, -h), Vector2(h, h), Vector2(-h, h)])
	a.color = COLORE_ASTEROIDE
	# parte da un bordo a caso: 0 alto, 1 basso, 2 sinistra, 3 destra
	var bordo: int = randi() % 4
	var pos: Vector2
	if bordo == 0:
		pos = Vector2(randf_range(0.0, vp.x), -h)
	elif bordo == 1:
		pos = Vector2(randf_range(0.0, vp.x), vp.y + h)
	elif bordo == 2:
		pos = Vector2(-h, randf_range(0.0, vp.y))
	else:
		pos = Vector2(vp.x + h, randf_range(0.0, vp.y))
	a.position = pos
	a.rotation = randf_range(0.0, TAU)
	# va verso un punto a caso dentro il campo, cosi' lo attraversa
	var mira: Vector2 = Vector2(randf_range(vp.x * 0.2, vp.x * 0.8), randf_range(vp.y * 0.2, vp.y * 0.8))
	var v: Vector2 = (mira - pos).normalized() * randf_range(VELOCITA_ASTEROIDI_MIN, VELOCITA_ASTEROIDI_MAX)
	campo.add_child(a)
	asteroidi.append({"n": a, "v": v, "r": h})

func _muovi_asteroidi(delta: float) -> void:
	var extra: float = 1.0 + tempo * 0.02   # col tempo vanno piu' veloci
	for it in asteroidi.duplicate():
		var a: Polygon2D = it["n"]
		a.position += it["v"] * delta * extra
		a.rotation += delta * 1.5
		if nave.position.distance_to(a.position) < RAGGIO_NAVE + it["r"] * 0.9:
			_game_over()
			return
		if a.position.x < -140.0 or a.position.x > vp.x + 140.0 or a.position.y < -140.0 or a.position.y > vp.y + 140.0:
			a.queue_free()
			asteroidi.erase(it)

func _game_over() -> void:
	in_gioco = false
	suonoBoomVar.play()
	clas.apri(int(tempo))

func _ricomincia() -> void:
	for it in asteroidi:
		it["n"].queue_free()
	asteroidi.clear()
	tempo = 0.0
	spawn_timer = 0.8
	in_gioco = true
	angolo = -PI / 2.0
	nave.position = vp / 2.0
	nave.rotation = angolo
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Tempo: %d" % int(tempo)
