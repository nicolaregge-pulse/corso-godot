extends Node2D
# GIOCO — Torta in faccia.
# Trascina il dito verso la faccia per MIRARE: una linea ti mostra l'ARCO dove
# cadra' la torta. Piu' lontano trascini, piu' forte tiri. Regoli con calma e
# lasci. Se tiri troppo forte va OLTRE (sopra), se piano cade prima. Punti
# secondo quanto e' vicino al centro il punto piu' alto dell'arco.
#
# LA FACCIA: e' il file sfondo.png (la foto a tutto schermo).

# ===== FALLO TUO =====
const TIRI_TOTALI: int = 5
const FORZA: float = 2.8             # quanto conta la lunghezza del trascinamento
const FORZA_MAX: float = 1750.0
const GRAVITA: float = 1600.0
# =====================

@onready var hudVar: Label = $hudScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var campo: Node2D
var faccia: Sprite2D
var bersaglio: Sprite2D
var torta: Sprite2D
var linea: Line2D
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
var dito: Vector2 = Vector2.ZERO
var tiri: int = 0
var punti: int = 0
var pausa: float = 0.0
var vp: Vector2
var suonoSplatVar: AudioStreamPlayer
var clas: CanvasLayer

func _ready() -> void:
	vp = get_viewport_rect().size
	campo = Node2D.new()
	add_child(campo)
	move_child(campo, 0)
	var sfondo_tex: Texture2D = load("res://sfondo.png")
	var bersaglio_tex: Texture2D = load("res://bersaglio.png")
	# il suono "splat" quando la torta centra la faccia
	suonoSplatVar = AudioStreamPlayer.new()
	suonoSplatVar.stream = load("res://splat.wav")
	add_child(suonoSplatVar)
	clas = preload("res://classifica.gd").new()
	clas.gioco = "torta"
	clas.etichetta = "punti"
	clas.al_rigioco = _ricomincia
	add_child(clas)
	centro = Vector2(vp.x * 0.5, vp.y * 0.505)
	half = 300.0
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
	linea = Line2D.new()
	linea.width = 7.0
	linea.default_color = Color(1, 1, 1, 0.9)
	campo.add_child(linea)
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
	if clas.aperta:
		return
	if not pronto or in_volo:
		return
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			puntando = true
			dito = event.position
		else:
			if puntando:
				puntando = false
				linea.points = PackedVector2Array()
				_lancia()
	elif (event is InputEventScreenDrag or event is InputEventMouseMotion) and puntando:
		dito = event.position

func _process(delta: float) -> void:
	if clas.aperta:
		return
	if tiri >= TIRI_TOTALI and not in_volo:
		return
	if not pronto and not in_volo and pausa > 0.0:
		pausa -= delta
		if pausa <= 0.0 and tiri < TIRI_TOTALI:
			_rimetti()
	if in_volo:
		_vola(delta)
	elif puntando and pronto:
		linea.points = _arco()

func _v0() -> Vector2:
	var tira: Vector2 = dito - ancora     # trascini verso dove vuoi mirare
	var v: Vector2 = tira * FORZA
	v.y = -abs(v.y)                        # sempre verso l'alto
	if v.length() > FORZA_MAX:
		v = v.normalized() * FORZA_MAX
	return v

func _arco() -> PackedVector2Array:
	var pts: PackedVector2Array = PackedVector2Array()
	if (dito - ancora).length() < 40.0:
		return pts
	var v: Vector2 = _v0()
	var p: Vector2 = ancora
	for i in range(40):
		pts.append(p)
		v.y += GRAVITA * 0.03
		p += v * 0.03
		if p.y > vp.y + 30.0 or p.x < -30.0 or p.x > vp.x + 30.0:
			break
	return pts

func _lancia() -> void:
	if (dito - ancora).length() < 40.0:
		return
	torta.position = ancora
	torta_v = _v0()
	in_volo = true
	pronto = false

func _vola(delta: float) -> void:
	var vy_prima: float = torta_v.y
	torta_v.y += GRAVITA * delta
	torta.position += torta_v * delta
	torta.rotation += delta * 10.0
	# volata sopra la testa: troppo forte, mancato
	if torta.position.y < -40.0:
		_mancato()
		return
	# apice dell'arco: era in salita, ora scende
	if vy_prima < 0.0 and torta_v.y >= 0.0:
		var d: float = torta.position.distance_to(centro)
		if d <= r10:
			_colpito(torta.position, d)
		else:
			_mancato()
		return
	# esce di lato o cade sotto
	if torta.position.y > vp.y + 150.0 or torta.position.x < -150.0 or torta.position.x > vp.x + 150.0:
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
	suonoSplatVar.play()
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
	clas.apri(punti)

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
	linea.points = PackedVector2Array()
	torta.position = ancora
	torta.rotation = 0.0
	torta.visible = true
	torta_v = Vector2.ZERO
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	hudVar.text = "Tiri: %d/%d    Punti: %d" % [tiri, TIRI_TOTALI, punti]
