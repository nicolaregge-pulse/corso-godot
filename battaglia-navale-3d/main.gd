extends Node3D
# ============================================================
#  BATTAGLIA NAVALE 3D — bombe di profondità 🌊💣
# ------------------------------------------------------------
#  Un CUBO di celle (l'acqua). Da qualche parte è nascosto UN
#  sottomarino. Sposti un MIRINO su una cella e lanci la BOMBA
#  DI PROFONDITÀ: esplode e colpisce una zona 3x3x3 attorno al
#  punto. Se il sottomarino è dentro quella zona -> COLPITO! 🎉
#
#  COORDINATE di ogni cella:
#    - Colonna    = LETTERA MAIUSCOLA  (A B C D E)
#    - Fila       = lettera minuscola  (a b c d e)
#    - Profondità = NUMERO             (1 2 3 4 5)
#
#  COMANDI:
#    - FRECCE ← → ↑ ↓ = muovi il mirino (colonna e fila)
#    - Q / E          = profondità (avanti / indietro)
#    - SPAZIO         = lancia la bomba sulla cella del mirino
#    - MOUSE trascinato = gira attorno al cubo (per vederlo in 3D)
#    - INVIO          = rigioca
# ============================================================

# ---- Parametri (cambiali per sperimentare!) ----------------
const LATO: int = 5           # cubo LATO x LATO x LATO (più grande = più difficile)
const SPAZIO: float = 1.4     # distanza tra i centri delle celle
const DIM_CELLA: float = 1.0  # dimensione del cubetto d'acqua
const RAGGIO_BOMBA: int = 1    # 1 = la bomba copre una zona 3x3x3

# ---- Colori ------------------------------------------------
const COL_ACQUA := Color(0.25, 0.55, 0.95, 0.14)     # celle d'acqua (trasparenti)
const COL_BOMBATA := Color(0.45, 0.50, 0.55, 0.32)   # celle già colpite
const COL_MIRINO := Color(0.25, 1.0, 0.70, 0.55)     # la cella puntata dal mirino
const COL_SUB := Color(0.92, 0.80, 0.12)             # il sottomarino (giallo)
const COL_ASSE_X := Color(1.0, 0.55, 0.55)           # colonne (lettere MAIUSCOLE)
const COL_ASSE_Y := Color(0.55, 1.0, 0.65)           # file (lettere minuscole)
const COL_ASSE_Z := Color(1.0, 0.92, 0.45)           # profondità (numeri)

# ---- Nodi / stato ------------------------------------------
var _perno_camera: Node3D
var _celle := {}              # Vector3i -> StaticBody3D
var _stato := {}              # Vector3i -> "acqua" | "bombata"
var _lbl_x := []              # etichette colonne (A B C…)
var _lbl_y := []              # etichette file (a b c…)
var _lbl_z := []              # etichette profondità (1 2 3…)
var _cursore: Vector3i        # la cella puntata dal mirino
var _sub_coord: Vector3i
var _sottomarino: Node3D
var _etichetta: Label
var _messaggio: String = ""
var _bombe: int = 0
var _vinto: bool = false


func _ready() -> void:
	randomize()
	_crea_ambiente()
	_crea_griglia()
	_crea_etichette_assi()
	_nuova_partita()


# ---- Luci, camera, sfondo, testo ----
func _crea_ambiente() -> void:
	var we := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.05, 0.09, 0.16)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.60, 0.70, 0.85)
	env.ambient_light_energy = 0.7
	we.environment = env
	add_child(we)

	var luce := DirectionalLight3D.new()
	luce.rotation_degrees = Vector3(-50, -35, 0)
	add_child(luce)

	# La telecamera sta su un PERNO: girando il perno, gira attorno al cubo
	_perno_camera = Node3D.new()
	add_child(_perno_camera)
	var cam := Camera3D.new()
	cam.position = Vector3(0, LATO * 0.6, LATO * SPAZIO + 4.0)
	_perno_camera.add_child(cam)
	cam.look_at(Vector3.ZERO, Vector3.UP)
	_perno_camera.rotation = Vector3(-0.30, 0.55, 0)

	var layer := CanvasLayer.new()
	add_child(layer)
	_etichetta = Label.new()
	_etichetta.position = Vector2(20, 16)
	_etichetta.add_theme_font_size_override("font_size", 22)
	_etichetta.add_theme_color_override("font_color", Color.WHITE)
	_etichetta.add_theme_color_override("font_outline_color", Color.BLACK)
	_etichetta.add_theme_constant_override("outline_size", 6)
	layer.add_child(_etichetta)


# ---- Il cubo di celle d'acqua ----
func _crea_griglia() -> void:
	for x in LATO:
		for y in LATO:
			for z in LATO:
				var coord := Vector3i(x, y, z)
				var corpo := StaticBody3D.new()
				corpo.position = _coord_to_world(coord)

				var col := CollisionShape3D.new()
				var forma := BoxShape3D.new()
				forma.size = Vector3.ONE * DIM_CELLA
				col.shape = forma
				corpo.add_child(col)

				var mesh := MeshInstance3D.new()
				var cubo := BoxMesh.new()
				cubo.size = Vector3.ONE * DIM_CELLA
				mesh.mesh = cubo
				corpo.add_child(mesh)
				corpo.set_meta("mesh", mesh)

				add_child(corpo)
				_celle[coord] = corpo
				_stato[coord] = "acqua"


# ---- Le lettere/numeri attorno al cubo (le coordinate) ----
func _crea_etichette_assi() -> void:
	var bordo := (LATO - 1) / 2.0 * SPAZIO + SPAZIO
	for i in LATO:
		var p := (i - (LATO - 1) / 2.0) * SPAZIO
		# Colonna: LETTERE MAIUSCOLE (rosso) sotto il cubo
		_lbl_x.append(_fai_etichetta(char(65 + i), Vector3(p, -bordo, bordo)))
		# Fila: lettere minuscole (verde) a sinistra
		_lbl_y.append(_fai_etichetta(char(97 + i), Vector3(-bordo, p, bordo)))
		# Profondità: NUMERI (giallo) in basso a sinistra, verso il fondo
		_lbl_z.append(_fai_etichetta(str(i + 1), Vector3(-bordo, -bordo, p)))


func _fai_etichetta(txt: String, pos: Vector3) -> Label3D:
	var l := Label3D.new()
	l.text = txt
	l.position = pos
	l.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	l.no_depth_test = true
	add_child(l)
	return l


# Ingrandisce e illumina la tripletta di coordinate della cella puntata
func _evidenzia_coordinate() -> void:
	for i in _lbl_x.size():
		_stile_etichetta(_lbl_x[i], i == _cursore.x, COL_ASSE_X)
	for i in _lbl_y.size():
		_stile_etichetta(_lbl_y[i], i == _cursore.y, COL_ASSE_Y)
	for i in _lbl_z.size():
		_stile_etichetta(_lbl_z[i], i == _cursore.z, COL_ASSE_Z)


func _stile_etichetta(l: Label3D, selezionata: bool, base: Color) -> void:
	if selezionata:
		l.pixel_size = 0.013
		l.font_size = 130
		l.modulate = Color.WHITE
		l.outline_modulate = base
		l.outline_size = 18
	else:
		l.pixel_size = 0.006
		l.font_size = 80
		l.modulate = base
		l.outline_size = 0


# ---- Inizio (o ri-inizio) di una partita ----
func _nuova_partita() -> void:
	_bombe = 0
	_vinto = false
	for coord in _celle:
		_stato[coord] = "acqua"
	_cursore = Vector3i(LATO / 2, LATO / 2, LATO / 2)   # mirino al centro
	for coord in _celle:
		_ridisegna_cella(coord)
	_evidenzia_coordinate()

	if _sottomarino != null and is_instance_valid(_sottomarino):
		_sottomarino.queue_free()
	_sub_coord = Vector3i(randi() % LATO, randi() % LATO, randi() % LATO)
	_sottomarino = _crea_sottomarino()
	_sottomarino.position = _coord_to_world(_sub_coord)
	_sottomarino.visible = false
	add_child(_sottomarino)

	_messaggio = "Muovi il mirino (frecce, Q/E) e premi SPAZIO per bombardare!"
	_aggiorna_testo()


# ---- Il sottomarino, costruito con forme semplici ----
func _crea_sottomarino() -> Node3D:
	var sub := Node3D.new()
	var mat := _materiale(COL_SUB)

	var scafo := MeshInstance3D.new()
	var capsula := CapsuleMesh.new()
	capsula.radius = 0.30
	capsula.height = 1.25
	scafo.mesh = capsula
	scafo.material_override = mat
	scafo.rotation_degrees = Vector3(0, 0, 90)
	sub.add_child(scafo)

	var torre := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.32, 0.24, 0.22)
	torre.mesh = box
	torre.material_override = mat
	torre.position = Vector3(0, 0.30, 0)
	sub.add_child(torre)

	var peri := MeshInstance3D.new()
	var cil := CylinderMesh.new()
	cil.top_radius = 0.03
	cil.bottom_radius = 0.03
	cil.height = 0.24
	peri.mesh = cil
	peri.material_override = mat
	peri.position = Vector3(0, 0.50, 0)
	sub.add_child(peri)

	return sub


# ---- Girare il cubo con i tasti A/D/W/S (in continuo) ----
func _process(delta: float) -> void:
	var v := 1.3 * delta
	if Input.is_key_pressed(KEY_A):
		_perno_camera.rotation.y += v
	if Input.is_key_pressed(KEY_D):
		_perno_camera.rotation.y -= v
	if Input.is_key_pressed(KEY_W):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x + v, -1.3, 1.3)
	if Input.is_key_pressed(KEY_S):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x - v, -1.3, 1.3)


# ---- Input: tastiera (mirino + spara + rigioca), mouse (gira) ----
func _unhandled_input(event: InputEvent) -> void:
	# Girare la telecamera trascinando il mouse
	if event is InputEventMouseMotion and (event.button_mask & MOUSE_BUTTON_MASK_LEFT):
		_perno_camera.rotation.y -= event.relative.x * 0.008
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x - event.relative.y * 0.008, -1.3, 1.3)
		return

	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_LEFT:  _muovi_cursore(Vector3i(-1, 0, 0))
			KEY_RIGHT: _muovi_cursore(Vector3i(1, 0, 0))
			KEY_UP:    _muovi_cursore(Vector3i(0, 1, 0))
			KEY_DOWN:  _muovi_cursore(Vector3i(0, -1, 0))
			KEY_Q:     _muovi_cursore(Vector3i(0, 0, -1))
			KEY_E:     _muovi_cursore(Vector3i(0, 0, 1))
			KEY_SPACE:
				if not _vinto:
					_lancia_bomba(_cursore)
			KEY_ENTER, KEY_KP_ENTER:
				_nuova_partita()


func _muovi_cursore(delta: Vector3i) -> void:
	var nuovo := _cursore + delta
	nuovo.x = clamp(nuovo.x, 0, LATO - 1)
	nuovo.y = clamp(nuovo.y, 0, LATO - 1)
	nuovo.z = clamp(nuovo.z, 0, LATO - 1)
	if nuovo == _cursore:
		return
	var vecchio := _cursore
	_cursore = nuovo
	_ridisegna_cella(vecchio)
	_ridisegna_cella(_cursore)
	_evidenzia_coordinate()
	_aggiorna_testo()


# ---- La bomba: esplode e copre una zona 3x3x3 ----
func _lancia_bomba(bersaglio: Vector3i) -> void:
	_bombe += 1
	var colpito := false
	for dx in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
		for dy in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
			for dz in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
				var c := bersaglio + Vector3i(dx, dy, dz)
				if _celle.has(c):
					_stato[c] = "bombata"
					_ridisegna_cella(c)
					if c == _sub_coord:
						colpito = true

	_esplosione(_coord_to_world(bersaglio), 1.0)

	if colpito:
		_vinto = true
		_sottomarino.visible = true
		_esplosione(_coord_to_world(_sub_coord), 2.4)
		_messaggio = "COLPITO! 🎉 Affondato con %d bombe. INVIO per rigiocare." % _bombe
	else:
		_messaggio = "Acqua… la zona 3x3x3 è esplosa. Continua! (bombe: %d)" % _bombe
	_aggiorna_testo()


# ---- L'effetto esplosione (particelle arancioni) ----
func _esplosione(posizione: Vector3, scala: float) -> void:
	var p := CPUParticles3D.new()
	p.position = posizione
	var scintilla := SphereMesh.new()
	scintilla.radius = 0.06 * scala
	scintilla.height = 0.12 * scala
	p.mesh = scintilla
	p.amount = 30
	p.one_shot = true
	p.explosiveness = 1.0
	p.lifetime = 0.9
	p.direction = Vector3.UP
	p.spread = 180.0
	p.initial_velocity_min = 2.0 * scala
	p.initial_velocity_max = 5.0 * scala
	p.gravity = Vector3(0, -4, 0)
	p.scale_amount_min = 0.5
	p.scale_amount_max = 1.4
	p.color = Color(1.0, 0.55, 0.10)
	add_child(p)
	p.emitting = true
	get_tree().create_timer(1.5).timeout.connect(p.queue_free)


# ---- Aiutini ----
func _ridisegna_cella(coord: Vector3i) -> void:
	var mesh := (_celle[coord] as StaticBody3D).get_meta("mesh") as MeshInstance3D
	if coord == _cursore:
		mesh.material_override = _materiale_mirino()
	elif _stato[coord] == "bombata":
		mesh.material_override = _materiale(COL_BOMBATA)
	else:
		mesh.material_override = _materiale(COL_ACQUA)


func _aggiorna_testo() -> void:
	_etichetta.text = "Mirino: %s   ·   %s" % [_coord_label(_cursore), _messaggio]


func _coord_label(c: Vector3i) -> String:
	return "%s %s %d" % [char(65 + c.x), char(97 + c.y), c.z + 1]


func _coord_to_world(c: Vector3i) -> Vector3:
	var meta := (LATO - 1) / 2.0
	return Vector3(c.x - meta, c.y - meta, c.z - meta) * SPAZIO


func _materiale(c: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	if c.a < 1.0:
		m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	return m


func _materiale_mirino() -> StandardMaterial3D:
	var m := _materiale(COL_MIRINO)
	m.emission_enabled = true
	m.emission = Color(0.2, 1.0, 0.7)
	m.emission_energy_multiplier = 1.3
	return m
