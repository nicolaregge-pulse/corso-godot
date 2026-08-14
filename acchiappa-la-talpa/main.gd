extends Node2D
# GIOCO — Acchiappa la talpa.
# Le talpe spuntano dai buchi: toccale con il dito o il clic per fare punti.
# La partita dura un tempo: piu' talpe prendi, piu' punti fai.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

# ===== FALLO TUO: cambia questi numeri, i colori e la scritta della talpa =====
const RIGHE: int = 3
const COLONNE: int = 3
const DURATA_PARTITA: float = 30.0      # quanti secondi dura una partita
const TEMPO_TALPA: float = 0.9          # quanti secondi resta su una talpa
const COLORE_BUCO: Color = Color(0.20, 0.14, 0.10)
# Vuoi un'altra talpa? Sostituisci il file talpa.png con una tua immagine o foto.
# =============================================================================

@onready var punteggioVar: Label = $punteggioScena
@onready var tempoVar: Label = $tempoScena
@onready var gameoverVar: Label = $gameoverScena
@onready var rigiocaVar: Button = $rigiocaScena

var buchi: Array = []
var talpa_attiva: int = -1
var punti: int = 0
var tempo_rimasto: float = DURATA_PARTITA
var tempo_prossima: float = 0.0
var in_gioco: bool = true
var talpa_tex: Texture2D

func _ready() -> void:
	talpa_tex = load("res://talpa.png")
	_crea_buchi()
	punteggioVar.position = Vector2(24, 24)
	punteggioVar.add_theme_font_size_override("font_size", 30)
	tempoVar.position = Vector2(24, 64)
	tempoVar.add_theme_font_size_override("font_size", 30)
	gameoverVar.add_theme_font_size_override("font_size", 40)
	gameoverVar.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gameoverVar.visible = false
	rigiocaVar.focus_mode = Control.FOCUS_NONE
	rigiocaVar.add_theme_font_size_override("font_size", 30)
	rigiocaVar.pressed.connect(_ricomincia)
	_posiziona_finali()
	rigiocaVar.visible = false
	_nuova_talpa()
	_aggiorna_hud()

func _crea_buchi() -> void:
	var vp: Vector2 = get_viewport_rect().size
	var margine: float = 40.0
	var top: float = 130.0
	var area_l: float = vp.x - margine * 2.0
	var area_h: float = vp.y - top - margine
	var passo_x: float = area_l / float(COLONNE)
	var passo_y: float = area_h / float(RIGHE)
	var lato: float = min(passo_x, passo_y) * 0.80
	var i: int = 0
	for r in RIGHE:
		for c in COLONNE:
			var b: Button = Button.new()
			b.size = Vector2(lato, lato)
			b.position = Vector2(margine + c * passo_x + (passo_x - lato) / 2.0, top + r * passo_y + (passo_y - lato) / 2.0)
			b.focus_mode = Control.FOCUS_NONE
			b.expand_icon = true
			var stile: StyleBoxFlat = StyleBoxFlat.new()
			stile.bg_color = COLORE_BUCO
			stile.set_corner_radius_all(int(lato * 0.5))
			b.add_theme_stylebox_override("normal", stile)
			b.add_theme_stylebox_override("hover", stile)
			b.add_theme_stylebox_override("pressed", stile)
			b.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
			var idx: int = i
			b.pressed.connect(func() -> void: _colpita(idx))
			add_child(b)
			buchi.append(b)
			i += 1

func _process(delta: float) -> void:
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):
			_ricomincia()
		return
	tempo_rimasto -= delta
	if tempo_rimasto <= 0.0:
		tempo_rimasto = 0.0
		_fine()
		return
	tempo_prossima -= delta
	if tempo_prossima <= 0.0:
		_nuova_talpa()
	_aggiorna_hud()

func _nuova_talpa() -> void:
	if talpa_attiva >= 0:
		_spegni(talpa_attiva)
	var nuovo: int = randi() % buchi.size()
	if buchi.size() > 1:
		while nuovo == talpa_attiva:
			nuovo = randi() % buchi.size()
	talpa_attiva = nuovo
	buchi[talpa_attiva].icon = talpa_tex
	tempo_prossima = TEMPO_TALPA

func _spegni(i: int) -> void:
	buchi[i].icon = null

func _colpita(idx: int) -> void:
	if not in_gioco:
		return
	if idx == talpa_attiva:
		punti += 1
		_aggiorna_hud()
		_nuova_talpa()

func _fine() -> void:
	in_gioco = false
	if talpa_attiva >= 0:
		_spegni(talpa_attiva)
		talpa_attiva = -1
	gameoverVar.text = "TEMPO!\nHai preso %d talpe" % punti
	gameoverVar.visible = true
	gameoverVar.move_to_front()
	rigiocaVar.visible = true
	rigiocaVar.move_to_front()

func _ricomincia() -> void:
	punti = 0
	tempo_rimasto = DURATA_PARTITA
	in_gioco = true
	gameoverVar.visible = false
	rigiocaVar.visible = false
	_nuova_talpa()
	_aggiorna_hud()

func _aggiorna_hud() -> void:
	punteggioVar.text = "Talpe: %d" % punti
	tempoVar.text = "Tempo: %d" % int(ceil(tempo_rimasto))

func _posiziona_finali() -> void:
	var vp: Vector2 = get_viewport_rect().size
	gameoverVar.size = Vector2(340, 90)
	gameoverVar.position = Vector2(vp.x / 2.0 - 170.0, vp.y * 0.34)
	rigiocaVar.size = Vector2(200, 60)
	rigiocaVar.position = Vector2(vp.x / 2.0 - 100.0, vp.y * 0.34 + 110.0)
