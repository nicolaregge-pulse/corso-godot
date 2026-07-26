extends Node3D
# ============================================================
#  AFFONDA LA BONOMI — battaglia navale 3D 🌊💣
# ------------------------------------------------------------
#  Un CUBO di celle (l'acqua). Da qualche parte è nascosto UN
#  sottomarino. Sposti un MIRINO e lanci la BOMBA DI PROFONDITÀ:
#  esplode e colpisce una zona 3x3x3. Se il sottomarino è dentro
#  quella zona -> COLPITO! 🎉
#
#  All'avvio (e a ogni "rigioca") scegli quanti cubi per lato (da 4 a 10).
#
#  COMANDI (3 colonne di tastiera QWERTY, su sopra / giù sotto):
#    - Q / A = Colonna (+/−)    · lettere ROSSE
#    - W / S = Fila (+/−)        · lettere VERDI
#    - E / D = Profondità (+/−)  · lettere GIALLE
#    - SHIFT + quelle lettere    = gira il cubo (invece del mirino)
#    - MOUSE/DITO trascinato     = gira il cubo
#    - SPAZIO = lancia la bomba · INVIO = rigioca
#
#  SUL TELEFONO: le tre coppie +/- colorate (in basso a sinistra) muovono
#  il mirino, il 💣 grande lancia, il dito trascinato gira il cubo.
# ============================================================

# ---- Parametri (cambiali per sperimentare!) ----------------
var LATO: int = 5             # scelto all'avvio (da 5 a 10)
const SPAZIO: float = 1.4     # distanza tra i centri delle celle
const DIM_CELLA: float = 1.0
const RAGGIO_BOMBA: int = 1    # 1 = zona 3x3x3

# ---- Colori ------------------------------------------------
const COL_ACQUA := Color(0.25, 0.55, 0.95, 0.14)
const COL_BOMBATA := Color(0.45, 0.50, 0.55, 0.32)
const COL_MIRINO := Color(0.25, 1.0, 0.70, 0.55)
const COL_SUB := Color(0.92, 0.80, 0.12)
const COL_ASSE_X := Color(1.0, 0.55, 0.55)   # colonna (A/D)
const COL_ASSE_Y := Color(0.55, 1.0, 0.65)   # fila (W/S)
const COL_ASSE_Z := Color(1.0, 0.92, 0.45)   # profondità (Q/E)

# ---- Nodi / stato ------------------------------------------
var _perno_camera: Node3D
var _celle := {}              # Vector3i -> MeshInstance3D
var _stato := {}              # Vector3i -> "acqua" | "bombata"
var _lbl_x := []
var _lbl_y := []
var _lbl_z := []
var _cursore: Vector3i
var _sub_coord: Vector3i
var _sottomarino: Node3D
var _etichetta: Label
var _touch_layer: CanvasLayer
var _menu: CanvasLayer
var _overlay: CanvasLayer
var _serena_root: Control
var _serena_img: TextureRect
var _serena_teschio: Label
var _mat_acqua: StandardMaterial3D
var _mat_bombata: StandardMaterial3D
var _mat_mirino: StandardMaterial3D
var _messaggio: String = ""
var _bombe: int = 0
var _vinto: bool = false
var _pronto: bool = false     # true dopo la scelta del lato


func _ready() -> void:
	randomize()
	_mostra_menu_inizio()


# =========================== MENU INIZIALE ===========================
func _mostra_menu_inizio() -> void:
	_menu = CanvasLayer.new()
	_menu.layer = 20
	add_child(_menu)
	var sfondo := ColorRect.new()
	sfondo.color = Color(0.05, 0.09, 0.16)
	sfondo.set_anchors_preset(Control.PRESET_FULL_RECT)
	_menu.add_child(sfondo)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	_menu.add_child(center)
	var vbox := VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 18)
	center.add_child(vbox)

	var titolo := Label.new()
	titolo.text = "AFFONDA LA BONOMI 🌊💣"
	titolo.add_theme_font_size_override("font_size", 40)
	titolo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(titolo)

	var dom := Label.new()
	dom.text = "Quanti cubi per lato?"
	dom.add_theme_font_size_override("font_size", 26)
	dom.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(dom)

	var riga := HBoxContainer.new()
	riga.alignment = BoxContainer.ALIGNMENT_CENTER
	riga.add_theme_constant_override("separation", 12)
	vbox.add_child(riga)
	for n in range(4, 11):
		var b := Button.new()
		b.text = str(n)
		b.custom_minimum_size = Vector2(78, 78)
		b.add_theme_font_size_override("font_size", 32)
		b.pressed.connect(_inizia.bind(n))
		riga.add_child(b)

	var nota := Label.new()
	nota.text = "(4 = facilissimo per provare · più grande = più difficile)"
	nota.add_theme_font_size_override("font_size", 18)
	nota.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(nota)


func _inizia(n: int) -> void:
	LATO = clampi(n, 4, 10)
	if _menu != null and is_instance_valid(_menu):
		_menu.queue_free()
	_crea_materiali()
	_crea_ambiente()
	_crea_griglia()
	_crea_etichette_assi()
	_crea_gizmo_assi()
	_crea_comandi_touch()
	_crea_overlay_serena()
	_pronto = true
	_nuova_partita()


# =========================== MONDO 3D ===========================
func _crea_materiali() -> void:
	_mat_acqua = _materiale(COL_ACQUA)
	_mat_bombata = _materiale(COL_BOMBATA)
	_mat_mirino = _materiale(COL_MIRINO)
	_mat_mirino.emission_enabled = true
	_mat_mirino.emission = Color(0.2, 1.0, 0.7)
	_mat_mirino.emission_energy_multiplier = 1.3


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


func _crea_griglia() -> void:
	for x in LATO:
		for y in LATO:
			for z in LATO:
				var coord := Vector3i(x, y, z)
				var mesh := MeshInstance3D.new()
				var cubo := BoxMesh.new()
				cubo.size = Vector3.ONE * DIM_CELLA
				mesh.mesh = cubo
				mesh.position = _coord_to_world(coord)
				mesh.material_override = _mat_acqua
				add_child(mesh)
				_celle[coord] = mesh
				_stato[coord] = "acqua"


# ---- Le lettere/numeri attorno al cubo (le coordinate) ----
func _crea_etichette_assi() -> void:
	var bordo := (LATO - 1) / 2.0 * SPAZIO + SPAZIO
	for i in LATO:
		var p := (i - (LATO - 1) / 2.0) * SPAZIO
		_lbl_x.append(_fai_etichetta(char(65 + i), Vector3(p, -bordo, bordo)))
		_lbl_y.append(_fai_etichetta(char(97 + i), Vector3(-bordo, p, bordo)))
		_lbl_z.append(_fai_etichetta(str(i + 1), Vector3(-bordo, -bordo, p)))


func _fai_etichetta(txt: String, pos: Vector3) -> Label3D:
	var l := Label3D.new()
	l.text = txt
	l.position = pos
	l.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	l.no_depth_test = true
	add_child(l)
	return l


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


# ---- Gizmo: 3 frecce colorate con le LETTERE dei tasti ----
# Messo nell'angolo POSTERIORE (−Z): lì lo spazio è vuoto e le sue lettere
# (Q/A · W/S · E/D) non si accavallano con le lettere-coordinate del cubo,
# che stanno tutte sul fronte (+Z) e sui bordi sinistro/basso.
func _crea_gizmo_assi() -> void:
	var half := (LATO - 1) / 2.0 * SPAZIO
	var org := Vector3(half + 0.9, -half - 0.9, -half - 0.9)
	var lung := 1.7
	_freccia_asse(org, Vector3(lung, 0, 0), COL_ASSE_X, "Q", "A")   # colonna: Q(+) A(−)
	_freccia_asse(org, Vector3(0, lung, 0), COL_ASSE_Y, "W", "S")   # fila:    W(+) S(−)
	_freccia_asse(org, Vector3(0, 0, lung), COL_ASSE_Z, "E", "D")   # prof:    E(+) D(−)


func _freccia_asse(org: Vector3, dir: Vector3, colore: Color, tasto_piu: String, tasto_meno: String) -> void:
	var spess := 0.07
	var asta := MeshInstance3D.new()
	var bm := BoxMesh.new()
	bm.size = Vector3(max(abs(dir.x), spess), max(abs(dir.y), spess), max(abs(dir.z), spess))
	asta.mesh = bm
	asta.material_override = _materiale(colore)
	asta.position = org + dir * 0.5
	add_child(asta)
	_lettera_gizmo(tasto_piu, org + dir * 1.3, colore)               # tasto "+"
	_lettera_gizmo(tasto_meno, org - dir.normalized() * 0.4, colore) # tasto "-"


func _lettera_gizmo(txt: String, pos: Vector3, colore: Color) -> void:
	var l := Label3D.new()
	l.text = txt
	l.position = pos
	l.font_size = 100
	l.pixel_size = 0.011
	l.modulate = colore
	l.outline_modulate = Color.BLACK
	l.outline_size = 12
	l.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	l.no_depth_test = true
	add_child(l)


# =========================== COMANDI A TOCCO ===========================
func _crea_comandi_touch() -> void:
	_touch_layer = CanvasLayer.new()
	add_child(_touch_layer)
	var bw := Vector2(74, 66)      # dimensione di ogni bottone
	var gap := 8.0                 # spazio tra su e giù
	var col_w := bw.x + 18.0       # distanza tra una colonna e l'altra
	# tre colonne verticali affiancate, in basso a sinistra (come la tastiera)
	_gruppo_asse("Colonna", COL_ASSE_X, "Q", "A", Vector3i(1, 0, 0), Vector2(24 + 0 * col_w, 30), bw, gap)
	_gruppo_asse("Fila",    COL_ASSE_Y, "W", "S", Vector3i(0, 1, 0), Vector2(24 + 1 * col_w, 30), bw, gap)
	_gruppo_asse("Prof.",   COL_ASSE_Z, "E", "D", Vector3i(0, 0, 1), Vector2(24 + 2 * col_w, 30), bw, gap)
	var bomba := _btn("💣", Vector2(150, 150), "br", Vector2(28, 28), _spara_touch)
	bomba.add_theme_font_size_override("font_size", 66)
	_btn("↻", Vector2(74, 58), "tr", Vector2(24, 20), _rigioca)


func _gruppo_asse(nome: String, colore: Color, lett_su: String, lett_giu: String, piu: Vector3i, base: Vector2, bw: Vector2, gap: float) -> void:
	# bottone GIÙ (in basso) e bottone SU (sopra), impilati come sulla tastiera
	_bottone_mov(lett_giu, bw, base, colore, -piu)
	_bottone_mov(lett_su, bw, base + Vector2(0, bw.y + gap), colore, piu)
	# nome dell'asse, colorato, sopra la colonna
	var lab := Label.new()
	lab.text = nome
	lab.add_theme_font_size_override("font_size", 16)
	lab.add_theme_color_override("font_color", colore)
	lab.add_theme_color_override("font_outline_color", Color.BLACK)
	lab.add_theme_constant_override("outline_size", 5)
	lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_touch_layer.add_child(lab)
	_ancora(lab, "bl", base + Vector2(0, 2 * bw.y + 2 * gap), Vector2(bw.x, 22))


func _bottone_mov(txt: String, dim: Vector2, margine: Vector2, colore: Color, passo: Vector3i) -> void:
	var b := Button.new()
	b.text = txt
	b.focus_mode = Control.FOCUS_NONE
	b.add_theme_font_size_override("font_size", 36)
	b.add_theme_color_override("font_color", colore)
	_touch_layer.add_child(b)
	_ancora(b, "bl", margine, dim)
	b.pressed.connect(_muovi_cursore.bind(passo))


func _btn(txt: String, dim: Vector2, corner: String, margine: Vector2, azione: Callable) -> Button:
	var b := Button.new()
	b.text = txt
	b.focus_mode = Control.FOCUS_NONE
	b.add_theme_font_size_override("font_size", 26)
	b.modulate = Color(1, 1, 1, 0.92)
	_touch_layer.add_child(b)
	_ancora(b, corner, margine, dim)
	b.pressed.connect(azione)
	return b


func _ancora(c: Control, corner: String, m: Vector2, dim: Vector2) -> void:
	match corner:
		"bl":
			c.anchor_left = 0; c.anchor_right = 0
			c.anchor_top = 1;  c.anchor_bottom = 1
			c.offset_left = m.x
			c.offset_right = m.x + dim.x
			c.offset_top = -m.y - dim.y
			c.offset_bottom = -m.y
		"br":
			c.anchor_left = 1; c.anchor_right = 1
			c.anchor_top = 1;  c.anchor_bottom = 1
			c.offset_left = -m.x - dim.x
			c.offset_right = -m.x
			c.offset_top = -m.y - dim.y
			c.offset_bottom = -m.y
		"tr":
			c.anchor_left = 1; c.anchor_right = 1
			c.anchor_top = 0;  c.anchor_bottom = 0
			c.offset_left = -m.x - dim.x
			c.offset_right = -m.x
			c.offset_top = m.y
			c.offset_bottom = m.y + dim.y


func _spara_touch() -> void:
	if _pronto and not _vinto:
		_lancia_bomba(_cursore)


# Rigioca = riparte da capo e RICHIEDE quanti cubi per lato (rimostra il menù).
func _rigioca() -> void:
	get_tree().reload_current_scene()


# =========================== SERENA / ESPLOSIONE ===========================
func _crea_overlay_serena() -> void:
	_overlay = CanvasLayer.new()
	_overlay.layer = 10
	add_child(_overlay)
	# Control a tutto schermo: su questo facciamo lampeggiare tutto insieme
	_serena_root = Control.new()
	_serena_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	_serena_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_overlay.add_child(_serena_root)
	# sfondo scuro semitrasparente, così la faccia/teschio risaltano
	var sfondo := ColorRect.new()
	sfondo.color = Color(0, 0, 0, 0.72)
	sfondo.set_anchors_preset(Control.PRESET_FULL_RECT)
	sfondo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_serena_root.add_child(sfondo)
	# la faccia di Serena: riempie lo schermo mantenendo le proporzioni (faccia intera)
	if ResourceLoader.exists("res://serena.jpg"):
		_serena_img = TextureRect.new()
		_serena_img.texture = load("res://serena.jpg")
		_serena_img.set_anchors_preset(Control.PRESET_FULL_RECT)
		_serena_img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		_serena_img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		_serena_img.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_serena_root.add_child(_serena_img)
	# il teschio con le ossa (bandiera dei pirati), STESSA area, sopra la faccia:
	# i due si alternano lampeggiando (vedi _mostra_serena_esplode)
	_serena_teschio = Label.new()
	_serena_teschio.text = "☠"
	_serena_teschio.add_theme_font_size_override("font_size", 420)
	_serena_teschio.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_serena_teschio.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_serena_teschio.set_anchors_preset(Control.PRESET_FULL_RECT)
	_serena_teschio.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_serena_root.add_child(_serena_teschio)
	_overlay.visible = false


func _mostra_serena_esplode() -> void:
	_overlay.visible = true
	_serena_root.modulate = Color(1, 1, 1, 1)
	# lampeggio alternato: prima la faccia, poi il teschio, di seguito
	_scambia_serena(true)
	if _serena_img != null:
		var tw := create_tween().set_loops(4)
		tw.tween_interval(0.22)
		tw.tween_callback(_scambia_serena.bind(false))   # mostra il teschio
		tw.tween_interval(0.22)
		tw.tween_callback(_scambia_serena.bind(true))    # rimostra la faccia
	get_tree().create_timer(2.0).timeout.connect(_fine_serena)


func _scambia_serena(mostra_faccia: bool) -> void:
	# se non c'è la foto, si vede solo il teschio
	if _serena_img != null and is_instance_valid(_serena_img):
		_serena_img.modulate.a = 1.0 if mostra_faccia else 0.0
		_serena_teschio.modulate.a = 0.0 if mostra_faccia else 1.0
	else:
		_serena_teschio.modulate.a = 1.0


func _fine_serena() -> void:
	if _overlay != null and is_instance_valid(_overlay):
		_overlay.visible = false
	if _sottomarino != null and is_instance_valid(_sottomarino):
		_sottomarino.visible = true
		_sottomarino.rotation_degrees = Vector3(0, 0, 28)   # affondato/inclinato


# =========================== PARTITA ===========================
func _nuova_partita() -> void:
	if not _pronto:
		return
	_bombe = 0
	_vinto = false
	if _overlay != null and is_instance_valid(_overlay):
		_overlay.visible = false
	for coord in _celle:
		_stato[coord] = "acqua"
	_cursore = Vector3i(LATO / 2, LATO / 2, LATO / 2)
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

	_messaggio = "Muovi il mirino (Q/A · W/S · E/D) e SPAZIO per bombardare!"
	_aggiorna_testo()


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


# =========================== INPUT ===========================
func _process(delta: float) -> void:
	if not _pronto or not Input.is_key_pressed(KEY_SHIFT):
		return
	var v := 1.3 * delta
	if Input.is_key_pressed(KEY_Q):
		_perno_camera.rotation.y += v
	if Input.is_key_pressed(KEY_A):
		_perno_camera.rotation.y -= v
	if Input.is_key_pressed(KEY_W):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x + v, -1.4, 1.4)
	if Input.is_key_pressed(KEY_S):
		_perno_camera.rotation.x = clamp(_perno_camera.rotation.x - v, -1.4, 1.4)
	if Input.is_key_pressed(KEY_E):
		_perno_camera.rotation.z += v
	if Input.is_key_pressed(KEY_D):
		_perno_camera.rotation.z -= v


func _unhandled_input(event: InputEvent) -> void:
	if not _pronto:
		return
	# Girare la telecamera trascinando (mouse o dito)
	if event is InputEventMouseMotion and (event.button_mask & MOUSE_BUTTON_MASK_LEFT):
		_gira_trascinando(event.relative)
		return
	if event is InputEventScreenDrag:
		_gira_trascinando(event.relative)
		return

	if event is InputEventKey and event.pressed and not event.echo:
		# con SHIFT le lettere girano il cubo (in _process): niente mirino
		if event.shift_pressed and event.keycode in [KEY_Q, KEY_A, KEY_W, KEY_S, KEY_E, KEY_D]:
			return
		match event.keycode:
			KEY_Q: _muovi_cursore(Vector3i(1, 0, 0))    # colonna +
			KEY_A: _muovi_cursore(Vector3i(-1, 0, 0))   # colonna −
			KEY_W: _muovi_cursore(Vector3i(0, 1, 0))    # fila +
			KEY_S: _muovi_cursore(Vector3i(0, -1, 0))   # fila −
			KEY_E: _muovi_cursore(Vector3i(0, 0, 1))    # profondità +
			KEY_D: _muovi_cursore(Vector3i(0, 0, -1))   # profondità −
			KEY_SPACE:
				if not _vinto:
					_lancia_bomba(_cursore)
			KEY_ENTER, KEY_KP_ENTER:
				_rigioca()


func _gira_trascinando(rel: Vector2) -> void:
	_perno_camera.rotation.y -= rel.x * 0.008
	_perno_camera.rotation.x = clamp(_perno_camera.rotation.x - rel.y * 0.008, -1.4, 1.4)


func _muovi_cursore(delta: Vector3i) -> void:
	if not _pronto or _vinto:
		return
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
		_esplosione(_coord_to_world(_sub_coord), 2.4)
		_mostra_serena_esplode()
		_messaggio = "COLPITO! 🎉 Affondato con %d bombe. INVIO o ↻ per rigiocare (e riscegliere la difficoltà)." % _bombe
	else:
		_messaggio = "Acqua… la zona 3x3x3 è esplosa. Continua! (bombe: %d)" % _bombe
	_aggiorna_testo()


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
	var mesh := _celle[coord] as MeshInstance3D
	if coord == _cursore:
		mesh.material_override = _mat_mirino
	elif _stato[coord] == "bombata":
		mesh.material_override = _mat_bombata
	else:
		mesh.material_override = _mat_acqua


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
