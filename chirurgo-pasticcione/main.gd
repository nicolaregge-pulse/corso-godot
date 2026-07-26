extends Node2D
# ============================================================
#  CHIRURGO PASTICCIONE — gioco completo 🩺
# ------------------------------------------------------------
#  Il chirurgo maldestro fa cadere gli organi dal tavolo!
#  Muovi il VASSOIO con le FRECCE ← → e prendili al volo:
#    - organo preso  -> +1 punto
#    - organo a terra -> perdi una vita
#    - zero vite      -> OPERAZIONE FALLITA (INVIO per riprovare)
# ============================================================

# ---- Parametri (cambiali per sperimentare!) ----------------
const VELOCITA_VASSOIO: float = 550.0
const VEL_ORGANO_MIN: float = 200.0
const VEL_ORGANO_MAX: float = 420.0
const INTERVALLO_SPAWN: float = 0.8      # secondi tra un organo e l'altro
const VITE_INIZIALI: int = 3
const LATO_ORGANO: float = 40.0

# ---- Nodi creati a runtime ---------------------------------
var vassoio: ColorRect
var etichetta_info: Label
var etichetta_gameover: Label

# ---- Stato del gioco ---------------------------------------
var organi: Array[ColorRect] = []
var punti: int = 0
var vite: int = VITE_INIZIALI
var in_gioco: bool = true
var dimensione_schermo: Vector2


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.08, 0.15, 0.15))
	dimensione_schermo = get_viewport_rect().size
	_crea_vassoio()
	_crea_interfaccia()

	# Timer che fa cadere un nuovo organo a intervalli regolari
	var timer := Timer.new()
	timer.wait_time = INTERVALLO_SPAWN
	timer.autostart = true
	timer.timeout.connect(_lascia_cadere_organo)
	add_child(timer)


func _crea_vassoio() -> void:
	vassoio = ColorRect.new()
	vassoio.color = Color(0.85, 0.85, 0.9)
	vassoio.size = Vector2(140, 24)
	vassoio.position = Vector2(dimensione_schermo.x / 2.0 - 70, dimensione_schermo.y - 60)
	add_child(vassoio)


func _crea_interfaccia() -> void:
	etichetta_info = Label.new()
	etichetta_info.position = Vector2(20, 20)
	add_child(etichetta_info)

	etichetta_gameover = Label.new()
	etichetta_gameover.position = Vector2(dimensione_schermo.x / 2.0 - 120, dimensione_schermo.y / 2.0 - 30)
	etichetta_gameover.visible = false
	add_child(etichetta_gameover)

	_aggiorna_interfaccia()


func _aggiorna_interfaccia() -> void:
	etichetta_info.text = "CHIRURGO PASTICCIONE   |   Organi salvati: %d   Vite: %d" % [punti, vite]


# Crea un organo in cima allo schermo, in una colonna a caso.
func _lascia_cadere_organo() -> void:
	if not in_gioco:
		return
	var organo := ColorRect.new()
	# Colore rossastro a caso (cuore, fegato, rene...)
	organo.color = Color(randf_range(0.7, 1.0), randf_range(0.1, 0.3), randf_range(0.1, 0.3))
	organo.size = Vector2(LATO_ORGANO, LATO_ORGANO)
	var x := randf_range(0, dimensione_schermo.x - LATO_ORGANO)
	organo.position = Vector2(x, -LATO_ORGANO)
	organo.set_meta("velocita", randf_range(VEL_ORGANO_MIN, VEL_ORGANO_MAX))
	add_child(organo)
	organi.append(organo)


func _process(delta: float) -> void:
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):   # INVIO / Spazio
			_ricomincia()
		return
	_muovi_vassoio(delta)
	_muovi_organi(delta)


func _muovi_vassoio(delta: float) -> void:
	var direzione := 0.0
	if Input.is_action_pressed("ui_left"):
		direzione -= 1.0
	if Input.is_action_pressed("ui_right"):
		direzione += 1.0
	vassoio.position.x += direzione * VELOCITA_VASSOIO * delta
	vassoio.position.x = clamp(vassoio.position.x, 0, dimensione_schermo.x - vassoio.size.x)


func _muovi_organi(delta: float) -> void:
	# Scorriamo AL CONTRARIO per rimuovere in sicurezza
	for i in range(organi.size() - 1, -1, -1):
		var organo := organi[i]
		organo.position.y += float(organo.get_meta("velocita")) * delta

		if _si_toccano(vassoio, organo):
			# Organo salvato sul vassoio!
			punti += 1
			_aggiorna_interfaccia()
			organo.queue_free()
			organi.remove_at(i)
		elif organo.position.y > dimensione_schermo.y:
			# Splat! Organo per terra
			vite -= 1
			_aggiorna_interfaccia()
			organo.queue_free()
			organi.remove_at(i)
			if vite <= 0:
				_game_over()


# Vero se due rettangoli si sovrappongono (collisione "AABB").
func _si_toccano(a: ColorRect, b: ColorRect) -> bool:
	return Rect2(a.position, a.size).intersects(Rect2(b.position, b.size))


func _game_over() -> void:
	in_gioco = false
	etichetta_gameover.text = "OPERAZIONE FALLITA!\nOrgani salvati: %d\nPremi INVIO per rioperare" % punti
	etichetta_gameover.visible = true


func _ricomincia() -> void:
	for organo in organi:
		organo.queue_free()
	organi.clear()
	punti = 0
	vite = VITE_INIZIALI
	in_gioco = true
	etichetta_gameover.visible = false
	vassoio.position.x = dimensione_schermo.x / 2.0 - 70
	_aggiorna_interfaccia()
