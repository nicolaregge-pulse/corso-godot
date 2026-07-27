extends Control
# ============================================================
#  GIOCO DEL QUINDICI CON LA FOTO 🧩
# ------------------------------------------------------------
#  Una foto viene tagliata in tante tessere (3x3 o 4x4). Una
#  tessera manca: resta un buco. Clicchi una tessera vicino al
#  buco e questa ci scivola dentro. Obiettivo: rimettere in
#  ordine le tessere e RICOMPORRE la foto.
#
#  All'avvio scegli la TUA foto (dal computer) o quella di
#  esempio, e la difficolta' (3x3 facile, 4x4 classico).
#  Le tessere hanno una cornice in stile LEGNO.
# ============================================================

# ---- Colori "legno" ----------------------------------------
const COL_SFONDO := Color(0.12, 0.10, 0.08)
const COL_LEGNO := Color(0.62, 0.40, 0.20)        # faccia della tessera
const COL_LEGNO_SCURO := Color(0.34, 0.20, 0.09)  # bordo/venatura
const COL_CORNICE := Color(0.28, 0.16, 0.07)      # cornice attorno al quadro

# ---- Stato -------------------------------------------------
var _n: int = 4                 # tessere per lato
var _tex: Texture2D             # la foto in gioco
var _tex_scelta: Texture2D      # la foto scelta nel menu (o null)
var _cella: float = 100.0
var _origine := Vector2.ZERO
var _board: Array = []          # posizione -> indice tessera (o -1 = buco)
var _vuoto: int = 0
var _tessere := {}              # indice tessera -> Panel
var _mosse: int = 0
var _vinto: bool = false
var _tavola: Control
var _hud: Label
var _menu: Control
var _stato_foto: Label
var _fd: FileDialog
var _vitt: Label


func _ready() -> void:
	randomize()
	set_anchors_preset(Control.PRESET_FULL_RECT)
	var bg := ColorRect.new()
	bg.color = COL_SFONDO
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)
	_mostra_menu()


# =========================== MENU ===========================
func _mostra_menu() -> void:
	_menu = CenterContainer.new()
	_menu.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(_menu)
	var v := VBoxContainer.new()
	v.alignment = BoxContainer.ALIGNMENT_CENTER
	v.add_theme_constant_override("separation", 14)
	_menu.add_child(v)

	var t := Label.new()
	t.text = "Gioco del Quindici"
	t.add_theme_font_size_override("font_size", 46)
	t.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(t)

	var s := Label.new()
	s.text = "Rimetti in ordine le tessere e ricomponi la foto."
	s.add_theme_font_size_override("font_size", 20)
	s.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(s)

	var lf := Label.new()
	lf.text = "1) Scegli la foto"
	lf.add_theme_font_size_override("font_size", 24)
	lf.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(lf)

	var rf := HBoxContainer.new()
	rf.alignment = BoxContainer.ALIGNMENT_CENTER
	rf.add_theme_constant_override("separation", 12)
	v.add_child(rf)
	var b1 := Button.new()
	b1.text = "Scegli dal computer…"
	b1.custom_minimum_size = Vector2(240, 56)
	b1.pressed.connect(_apri_file_dialog)
	rf.add_child(b1)
	var b2 := Button.new()
	b2.text = "Foto di esempio"
	b2.custom_minimum_size = Vector2(190, 56)
	b2.pressed.connect(_usa_esempio)
	rf.add_child(b2)

	_stato_foto = Label.new()
	_stato_foto.text = "Foto: nessuna (userò l'esempio)"
	_stato_foto.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(_stato_foto)

	var ld := Label.new()
	ld.text = "2) Scegli la difficoltà"
	ld.add_theme_font_size_override("font_size", 24)
	ld.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(ld)

	var rd := HBoxContainer.new()
	rd.alignment = BoxContainer.ALIGNMENT_CENTER
	rd.add_theme_constant_override("separation", 12)
	v.add_child(rd)
	var e3 := Button.new()
	e3.text = "3 × 3 (facile)"
	e3.custom_minimum_size = Vector2(180, 66)
	e3.pressed.connect(_inizia.bind(3))
	rd.add_child(e3)
	var e4 := Button.new()
	e4.text = "4 × 4 (classico)"
	e4.custom_minimum_size = Vector2(200, 66)
	e4.pressed.connect(_inizia.bind(4))
	rd.add_child(e4)


func _apri_file_dialog() -> void:
	if _fd == null:
		_fd = FileDialog.new()
		_fd.file_mode = FileDialog.FILE_MODE_OPEN_FILE
		_fd.access = FileDialog.ACCESS_FILESYSTEM
		_fd.use_native_dialog = true
		_fd.filters = PackedStringArray(["*.png, *.jpg, *.jpeg ; Immagini"])
		_fd.file_selected.connect(_on_file_scelto)
		add_child(_fd)
	_fd.popup_centered(Vector2i(820, 560))


func _on_file_scelto(path: String) -> void:
	var img := Image.new()
	if img.load(path) == OK:
		_tex_scelta = ImageTexture.create_from_image(img)
		_stato_foto.text = "Foto scelta ✓"
	else:
		_stato_foto.text = "Non riesco ad aprire quella foto, riprova."


func _usa_esempio() -> void:
	_tex_scelta = _foto_esempio()
	_stato_foto.text = "Foto: esempio ✓"


func _foto_esempio() -> Texture2D:
	# Genera una foto colorata (un arcobaleno) così c'è sempre qualcosa da ricomporre.
	var s := 480
	var img := Image.create(s, s, false, Image.FORMAT_RGB8)
	for y in s:
		for x in s:
			var a := Color.from_hsv(float(x) / s, 0.55, 0.98)
			var b := Color.from_hsv(float(y) / s, 0.75, 0.90)
			img.set_pixel(x, y, a.lerp(b, 0.5))
	return ImageTexture.create_from_image(img)


# =========================== PARTITA ===========================
func _inizia(n: int) -> void:
	_n = n
	if _tex_scelta == null:
		_tex_scelta = _foto_esempio()
	_tex = _tex_scelta
	if _menu != null and is_instance_valid(_menu):
		_menu.queue_free()
		_menu = null
	_crea_hud()
	_crea_tavola()
	_nuova_partita()


func _crea_hud() -> void:
	_hud = Label.new()
	_hud.position = Vector2(20, 14)
	_hud.add_theme_font_size_override("font_size", 22)
	_hud.add_theme_color_override("font_color", Color(0.95, 0.92, 0.85))
	add_child(_hud)
	var b := Button.new()
	b.text = "↻ Rimescola"
	b.position = Vector2(20, 50)
	b.pressed.connect(_nuova_partita)
	add_child(b)
	var b2 := Button.new()
	b2.text = "Menu"
	b2.position = Vector2(168, 50)
	b2.pressed.connect(_torna_menu)
	add_child(b2)


func _crea_tavola() -> void:
	var vp := get_viewport_rect().size
	var lato := minf(vp.x, vp.y) * 0.80
	_cella = lato / _n
	_origine = Vector2((vp.x - lato) / 2.0, (vp.y - lato) / 2.0 + 24.0)

	# Cornice in legno attorno al quadro
	var cornice := Panel.new()
	var sbc := StyleBoxFlat.new()
	sbc.bg_color = COL_CORNICE
	sbc.set_corner_radius_all(10)
	cornice.add_theme_stylebox_override("panel", sbc)
	var m := _cella * 0.16
	cornice.position = _origine - Vector2(m, m)
	cornice.size = Vector2(lato, lato) + Vector2(m, m) * 2.0
	cornice.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(cornice)

	_tavola = Control.new()
	_tavola.position = _origine
	_tavola.size = Vector2(lato, lato)
	add_child(_tavola)


func _nuova_partita() -> void:
	if _tavola == null:
		return
	_vinto = false
	_mosse = 0
	if _vitt != null and is_instance_valid(_vitt):
		_vitt.queue_free()
		_vitt = null
	for c in _tavola.get_children():
		c.queue_free()
	_tessere.clear()

	var tot := _n * _n
	_board = []
	for i in tot:
		_board.append(i)      # ordinata: posizione i -> tessera i
	_board[tot - 1] = -1      # l'ultima casella è il buco
	_vuoto = tot - 1

	for indice in range(tot - 1):
		var pan := _crea_tessera(indice)
		_tessere[indice] = pan
		_tavola.add_child(pan)

	_mescola()
	for indice in _tessere:
		_tessere[indice].position = _pixel(_posizione_di(indice))
	_aggiorna_testo()


func _crea_tessera(indice: int) -> Panel:
	var pan := Panel.new()
	pan.size = Vector2(_cella, _cella)
	var sb := StyleBoxFlat.new()
	sb.bg_color = COL_LEGNO
	sb.set_border_width_all(maxi(2, int(_cella * 0.06)))
	sb.border_color = COL_LEGNO_SCURO
	sb.set_corner_radius_all(6)
	pan.add_theme_stylebox_override("panel", sb)

	# Il pezzo di foto di questa tessera (ritaglio quadrato centrato).
	var tw := _tex.get_width()
	var th := _tex.get_height()
	var side := mini(tw, th)
	var ox := (tw - side) / 2.0
	var oy := (th - side) / 2.0
	var cs := side / float(_n)
	var col := indice % _n
	var row := int(indice / _n)
	var at := AtlasTexture.new()
	at.atlas = _tex
	at.region = Rect2(ox + col * cs, oy + row * cs, cs, cs)

	var tr := TextureRect.new()
	tr.texture = at
	tr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tr.stretch_mode = TextureRect.STRETCH_SCALE
	tr.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var b := _cella * 0.09
	tr.position = Vector2(b, b)
	tr.size = Vector2(_cella - 2.0 * b, _cella - 2.0 * b)
	pan.add_child(tr)

	pan.mouse_filter = Control.MOUSE_FILTER_STOP
	pan.gui_input.connect(_su_tessera.bind(indice))
	return pan


func _su_tessera(event: InputEvent, indice: int) -> void:
	if event is InputEventMouseButton and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		_prova_muovi(indice)


func _prova_muovi(indice: int) -> void:
	if _vinto:
		return
	var p := _posizione_di(indice)
	if not _adiacente(p, _vuoto):
		return
	var dest := _vuoto
	_board[dest] = indice
	_board[p] = -1
	_vuoto = p
	_mosse += 1
	var tw := create_tween()
	tw.tween_property(_tessere[indice], "position", _pixel(dest), 0.11)
	_aggiorna_testo()
	if _risolto():
		_vittoria()


# ---- Aiutini ----
func _posizione_di(indice: int) -> int:
	return _board.find(indice)


func _adiacente(a: int, b: int) -> bool:
	var ar := int(a / _n)
	var ac := a % _n
	var br := int(b / _n)
	var bc := b % _n
	return (ar == br and abs(ac - bc) == 1) or (ac == bc and abs(ar - br) == 1)


func _pixel(pos: int) -> Vector2:
	return Vector2((pos % _n) * _cella, int(pos / _n) * _cella)


func _vicini(pos: int) -> Array:
	var out := []
	var r := int(pos / _n)
	var c := pos % _n
	if r > 0: out.append(pos - _n)
	if r < _n - 1: out.append(pos + _n)
	if c > 0: out.append(pos - 1)
	if c < _n - 1: out.append(pos + 1)
	return out


func _mescola() -> void:
	# Tante mosse casuali VALIDE: così il puzzle è sempre risolvibile.
	for i in _n * _n * 40:
		var vic := _vicini(_vuoto)
		var scelto: int = vic[randi() % vic.size()]
		_board[_vuoto] = _board[scelto]
		_board[scelto] = -1
		_vuoto = scelto
	if _risolto():   # capitasse (raro) di uscire già ordinati, una mossa in più
		var vic := _vicini(_vuoto)
		_board[_vuoto] = _board[vic[0]]
		_board[vic[0]] = -1
		_vuoto = vic[0]


func _risolto() -> bool:
	for pos in range(_n * _n - 1):
		if _board[pos] != pos:
			return false
	return true


func _vittoria() -> void:
	_vinto = true
	# Rivela anche la tessera mancante: la foto torna intera.
	var mancante := _n * _n - 1
	if not _tessere.has(mancante):
		var t := _crea_tessera(mancante)
		_tavola.add_child(t)
		_tessere[mancante] = t
	_board[_n * _n - 1] = mancante
	_tessere[mancante].position = _pixel(_n * _n - 1)

	_vitt = Label.new()
	_vitt.text = "COMPLIMENTI!\nFoto ricomposta in %d mosse." % _mosse
	_vitt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_vitt.add_theme_font_size_override("font_size", 32)
	_vitt.add_theme_color_override("font_color", Color(1, 1, 0.7))
	_vitt.add_theme_color_override("font_outline_color", Color.BLACK)
	_vitt.add_theme_constant_override("outline_size", 8)
	var vp := get_viewport_rect().size
	_vitt.size = Vector2(vp.x, 90)
	_vitt.position = Vector2(0, 12)
	add_child(_vitt)
	_aggiorna_testo()


func _aggiorna_testo() -> void:
	if _hud == null:
		return
	if _vinto:
		_hud.text = "Fatto! Foto ricomposta in %d mosse." % _mosse
	else:
		_hud.text = "Mosse: %d   ·   rimetti in ordine la foto" % _mosse


func _torna_menu() -> void:
	get_tree().reload_current_scene()
