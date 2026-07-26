extends Node2D
# ============================================================
#  ACCHIAPPA LE STELLE — mini gioco di esempio in GDScript
# ------------------------------------------------------------
#  Come si gioca:
#    - Muovi la navetta con le FRECCE sinistra/destra
#    - Prendi le stelle che cadono   -> +1 punto
#    - Se una stella tocca terra     -> perdi una vita
#    - A zero vite: GAME OVER -> premi INVIO per ricominciare
#
#  Tutto il gioco è costruito "da codice" (senza trascinare
#  nodi nell'editor) così puoi leggere in un unico file come
#  funziona. Cambia i valori in alto per sperimentare!
# ============================================================


# ---- Parametri di gioco (prova a cambiarli!) ---------------
const LARGHEZZA_SCHERMO: int = 480
const ALTEZZA_SCHERMO: int = 720
const VELOCITA_NAVETTA: float = 400.0        # pixel al secondo
const VELOCITA_STELLA_MIN: float = 150.0
const VELOCITA_STELLA_MAX: float = 300.0
const INTERVALLO_SPAWN: float = 0.8          # secondi tra una stella e l'altra
const VITE_INIZIALI: int = 3


# ---- Riferimenti ai nodi creati mentre il gioco parte ------
var navetta: ColorRect
var etichetta_punti: Label
var etichetta_gameover: Label


# ---- Stato del gioco ---------------------------------------
var stelle: Array[ColorRect] = []            # stelle attualmente sullo schermo
var punti: int = 0
var vite: int = VITE_INIZIALI
var in_gioco: bool = true


# _ready() viene chiamata UNA volta da Godot quando la scena parte.
func _ready() -> void:
	# Colore di sfondo (blu notte)
	RenderingServer.set_default_clear_color(Color(0.05, 0.05, 0.12))
	_crea_navetta()
	_crea_interfaccia()

	# Un Timer genera una nuova stella a intervalli regolari.
	var timer := Timer.new()
	timer.wait_time = INTERVALLO_SPAWN
	timer.autostart = true
	timer.timeout.connect(_genera_stella)   # collega il "tick" alla funzione
	add_child(timer)


func _crea_navetta() -> void:
	navetta = ColorRect.new()
	navetta.color = Color(0.3, 0.7, 1.0)     # azzurro
	navetta.size = Vector2(80, 20)
	navetta.position = Vector2(LARGHEZZA_SCHERMO / 2.0 - 40, ALTEZZA_SCHERMO - 50)
	add_child(navetta)


func _crea_interfaccia() -> void:
	etichetta_punti = Label.new()
	etichetta_punti.position = Vector2(10, 10)
	add_child(etichetta_punti)

	etichetta_gameover = Label.new()
	etichetta_gameover.position = Vector2(LARGHEZZA_SCHERMO / 2.0 - 130, ALTEZZA_SCHERMO / 2.0 - 20)
	etichetta_gameover.text = "GAME OVER\nPremi INVIO per ricominciare"
	etichetta_gameover.visible = false
	add_child(etichetta_gameover)

	_aggiorna_interfaccia()


func _aggiorna_interfaccia() -> void:
	etichetta_punti.text = "Punti: %d    Vite: %d" % [punti, vite]


# Crea una stella in cima allo schermo, in una colonna a caso.
func _genera_stella() -> void:
	if not in_gioco:
		return
	var stella := ColorRect.new()
	stella.color = Color(1.0, 0.85, 0.2)     # giallo
	stella.size = Vector2(24, 24)
	var x := randf_range(0, LARGHEZZA_SCHERMO - 24)
	stella.position = Vector2(x, -24)
	# Ogni stella si porta dietro la sua velocità (salvata come "meta").
	stella.set_meta("velocita", randf_range(VELOCITA_STELLA_MIN, VELOCITA_STELLA_MAX))
	add_child(stella)
	stelle.append(stella)


# _process() viene chiamata a OGNI fotogramma. "delta" è il tempo
# (in secondi) passato dal fotogramma precedente: lo usiamo per
# muovere le cose in modo fluido su qualsiasi PC.
func _process(delta: float) -> void:
	if not in_gioco:
		if Input.is_action_just_pressed("ui_accept"):   # INVIO / Spazio
			_ricomincia()
		return
	_muovi_navetta(delta)
	_muovi_stelle(delta)


func _muovi_navetta(delta: float) -> void:
	var direzione := 0.0
	if Input.is_action_pressed("ui_left"):
		direzione -= 1.0
	if Input.is_action_pressed("ui_right"):
		direzione += 1.0
	navetta.position.x += direzione * VELOCITA_NAVETTA * delta
	# La teniamo dentro i bordi dello schermo.
	navetta.position.x = clamp(navetta.position.x, 0, LARGHEZZA_SCHERMO - navetta.size.x)


func _muovi_stelle(delta: float) -> void:
	# Scorriamo la lista AL CONTRARIO così possiamo togliere
	# elementi in sicurezza mentre la percorriamo.
	for i in range(stelle.size() - 1, -1, -1):
		var stella := stelle[i]
		stella.position.y += float(stella.get_meta("velocita")) * delta

		if _si_toccano(navetta, stella):
			# Stella presa!
			punti += 1
			_aggiorna_interfaccia()
			stella.queue_free()          # rimuove il nodo da Godot
			stelle.remove_at(i)          # rimuove dalla nostra lista
		elif stella.position.y > ALTEZZA_SCHERMO:
			# Stella persa
			vite -= 1
			_aggiorna_interfaccia()
			stella.queue_free()
			stelle.remove_at(i)
			if vite <= 0:
				_game_over()


# Vero se due rettangoli si sovrappongono (collisione "AABB").
func _si_toccano(a: ColorRect, b: ColorRect) -> bool:
	var ra := Rect2(a.position, a.size)
	var rb := Rect2(b.position, b.size)
	return ra.intersects(rb)


func _game_over() -> void:
	in_gioco = false
	etichetta_gameover.visible = true


func _ricomincia() -> void:
	for stella in stelle:
		stella.queue_free()
	stelle.clear()
	punti = 0
	vite = VITE_INIZIALI
	in_gioco = true
	etichetta_gameover.visible = false
	navetta.position.x = LARGHEZZA_SCHERMO / 2.0 - 40
	_aggiorna_interfaccia()
