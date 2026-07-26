extends Node3D
# ============================================================
#  BATTAGLIA NAVALE 3D — bombe di profondità 🌊💣
# ------------------------------------------------------------
#  Un CUBO di celle (l'acqua). Da qualche parte è nascosto UN
#  sottomarino. Clicca una cella per lanciare una BOMBA DI
#  PROFONDITÀ: esplode e colpisce una zona 3x3x3 attorno al
#  punto. Se il sottomarino è dentro quella zona -> COLPITO! 🎉
#
#  COMANDI:
#    - MOUSE (clic sinistro) = lancia la bomba sulla cella
#    - FRECCE ← → ↑ ↓        = gira attorno al cubo (per vederlo in 3D)
#    - INVIO                 = rigioca (nuova partita)
# ============================================================

# ---- Parametri (cambiali per sperimentare!) ----------------
const LATO: int = 4           # cubo LATO x LATO x LATO (prova 5 per renderlo più difficile)
const SPAZIO: float = 1.35    # distanza tra i centri delle celle
const DIM_CELLA: float = 1.0  # dimensione del cubetto d'acqua
const RAGGIO_BOMBA: int = 1    # 1 = la bomba copre una zona 3x3x3

# ---- Colori ------------------------------------------------
const COL_ACQUA := Color(0.25, 0.55, 0.95, 0.16)     # celle d'acqua (trasparenti)
const COL_BOMBATA := Color(0.45, 0.5, 0.55, 0.30)    # celle già colpite dalla bomba
const COL_SUB := Color(0.90, 0.78, 0.15)             # il sottomarino (giallo)

# ---- Nodi / stato ------------------------------------------
var _perno_camera: Node3D
var _celle := {}              # Vector3i -> StaticBody3D
var _sub_coord: Vector3i
var _sottomarino: Node3D
var _etichetta: Label
var _bombe: int = 0
var _vinto: bool = false


func _ready() -> void:
	randomize()
	_crea_ambiente()
	_crea_griglia()
	_nuova_partita()


# ---- Costruzione della "stanza" (luci, camera, sfondo, testo) ----
func _crea_ambiente() -> void:
	# Sfondo blu profondo + un po' di luce ambientale
	var we := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.05, 0.09, 0.16)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.60, 0.70, 0.85)
	env.ambient_light_energy = 0.7
	we.environment = env
	add_child(we)

	# La "luce del sole"
	var luce := DirectionalLight3D.new()
	luce.rotation_degrees = Vector3(-50, -35, 0)
	add_child(luce)

	# La telecamera sta su un PERNO: girando il perno, gira attorno al cubo
	_perno_camera = Node3D.new()
	add_child(_perno_camera)
	var cam := Camera3D.new()
	cam.position = Vector3(0, 2.5, LATO * SPAZIO + 3.5)
	_perno_camera.add_child(cam)
	cam.look_at(Vector3.ZERO, Vector3.UP)
	# angolo di partenza: vista di 3/4 così si vede la profondità
	_perno_camera.rotation = Vector3(-0.30, 0.55, 0)

	# Scritta a schermo (istruzioni + risultato)
	var layer := CanvasLayer.new()
	add_child(layer)
	_etichetta = Label.new()
	_etichetta.position = Vector2(20, 16)
	_etichetta.add_theme_font_size_override("font_size", 22)
	_etichetta.add_theme_color_override("font_color", Color.WHITE)
	_etichetta.add_theme_color_override("font_outline_color", Color.BLACK)
	_etichetta.add_theme_constant_override("outline_size", 6)
	layer.add_child(_etichetta)


# ---- Costruzione del cubo di celle d'acqua ----
func _crea_griglia() -> void:
	for x in LATO:
		for y in LATO:
			for z in LATO:
				var coord := Vector3i(x, y, z)
				# un corpo statico: serve per capire dove clicchi (il raggio lo "colpisce")
				var corpo := StaticBody3D.new()
				corpo.position = _coord_to_world(coord)
				corpo.set_meta("coord", coord)

				var col := CollisionShape3D.new()
				var forma := BoxShape3D.new()
				forma.size = Vector3.ONE * DIM_CELLA
				col.shape = forma
				corpo.add_child(col)

				var mesh := MeshInstance3D.new()
				var cubo := BoxMesh.new()
				cubo.size = Vector3.ONE * DIM_CELLA
				mesh.mesh = cubo
				mesh.material_override = _materiale(COL_ACQUA)
				corpo.add_child(mesh)
				corpo.set_meta("mesh", mesh)

				add_child(corpo)
				_celle[coord] = corpo


# ---- Inizio (o ri-inizio) di una partita ----
func _nuova_partita() -> void:
	_bombe = 0
	_vinto = false
	# rimetti tutte le celle "acqua"
	for coord in _celle:
		var corpo: StaticBody3D = _celle[coord]
		(corpo.get_meta("mesh") as MeshInstance3D).material_override = _materiale(COL_ACQUA)
	# togli il vecchio sottomarino, se c'era
	if _sottomarino != null and is_instance_valid(_sottomarino):
		_sottomarino.queue_free()
	# nascondi UN sottomarino in una cella a caso
	_sub_coord = Vector3i(randi() % LATO, randi() % LATO, randi() % LATO)
	_sottomarino = _crea_sottomarino()
	_sottomarino.position = _coord_to_world(_sub_coord)
	_sottomarino.visible = false
	add_child(_sottomarino)
	_etichetta.text = "Clicca una cella per lanciare la bomba di profondità! 🌊\nFrecce = gira il cubo · INVIO = rigioca"


# ---- Il sottomarino, costruito con forme semplici ----
func _crea_sottomarino() -> Node3D:
	var sub := Node3D.new()
	var mat := _materiale(COL_SUB)

	# scafo: una capsula "sdraiata"
	var scafo := MeshInstance3D.new()
	var capsula := CapsuleMesh.new()
	capsula.radius = 0.22
	capsula.height = 0.95
	scafo.mesh = capsula
	scafo.material_override = mat
	scafo.rotation_degrees = Vector3(0, 0, 90)
	sub.add_child(scafo)

	# torretta: un cubetto sopra
	var torre := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.24, 0.18, 0.16)
	torre.mesh = box
	torre.material_override = mat
	torre.position = Vector3(0, 0.22, 0)
	sub.add_child(torre)

	# periscopio: un bastoncino
	var peri := MeshInstance3D.new()
	var cil := CylinderMesh.new()
	cil.top_radius = 0.025
	cil.bottom_radius = 0.025
	cil.height = 0.18
	peri.mesh = cil
	peri.material_override = mat
	peri.position = Vector3(0, 0.37, 0)
	sub.add_child(peri)

	return sub


# ---- Il game loop: le frecce girano la telecamera ----
func _process(delta: float) -> void:
	var vel := 1.4 * delta
	if Input.is_action_pressed("ui_left"):
		_perno_camera.rotation.y += vel
	if Input.is_action_pressed("ui_right"):
		_perno_camera.rotation.y -= vel
	if Input.is_action_pressed("ui_up"):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x + vel, -1.2, 1.2)
	if Input.is_action_pressed("ui_down"):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x - vel, -1.2, 1.2)


# ---- Input: clic del mouse (spara) e INVIO (rigioca) ----
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_nuova_partita()
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not _vinto:
			_spara(event.position)


# ---- Da dove ho cliccato -> quale cella del cubo ----
func _spara(pos_mouse: Vector2) -> void:
	var cam := get_viewport().get_camera_3d()
	if cam == null:
		return
	var da := cam.project_ray_origin(pos_mouse)
	var a := da + cam.project_ray_normal(pos_mouse) * 1000.0
	var spazio := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(da, a)
	var colpo := spazio.intersect_ray(query)
	if colpo.is_empty():
		return
	var corpo = colpo.collider
	if corpo == null or not corpo.has_meta("coord"):
		return
	_lancia_bomba(corpo.get_meta("coord"))


# ---- La bomba: esplode e copre una zona 3x3x3 ----
func _lancia_bomba(bersaglio: Vector3i) -> void:
	_bombe += 1
	var colpito := false
	for dx in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
		for dy in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
			for dz in range(-RAGGIO_BOMBA, RAGGIO_BOMBA + 1):
				var c := bersaglio + Vector3i(dx, dy, dz)
				if _celle.has(c):
					var corpo: StaticBody3D = _celle[c]
					(corpo.get_meta("mesh") as MeshInstance3D).material_override = _materiale(COL_BOMBATA)
					if c == _sub_coord:
						colpito = true

	_esplosione(_coord_to_world(bersaglio), 1.0)

	if colpito:
		_vinto = true
		_sottomarino.visible = true
		_esplosione(_coord_to_world(_sub_coord), 2.2)
		_etichetta.text = "COLPITO! 🎉  Sottomarino affondato con %d bombe.\nINVIO per rigiocare." % _bombe
	else:
		_etichetta.text = "Acqua… ma la zona 3x3x3 è esplosa! Bombe lanciate: %d\nFrecce = gira · INVIO = rigioca" % _bombe


# ---- L'effetto esplosione (particelle arancioni) ----
func _esplosione(posizione: Vector3, scala: float) -> void:
	var p := CPUParticles3D.new()
	p.position = posizione
	var scintilla := SphereMesh.new()
	scintilla.radius = 0.06 * scala
	scintilla.height = 0.12 * scala
	p.mesh = scintilla
	p.amount = 28
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
	# si cancella da sola dopo un po'
	get_tree().create_timer(1.5).timeout.connect(p.queue_free)


# ---- Aiutini ----
func _coord_to_world(c: Vector3i) -> Vector3:
	var meta := (LATO - 1) / 2.0
	return Vector3(c.x - meta, c.y - meta, c.z - meta) * SPAZIO


func _materiale(c: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	if c.a < 1.0:
		m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	return m
