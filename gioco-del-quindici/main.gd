extends Control
# ============================================================
#  GIOCO DEL QUINDICI CON LA FOTO
# ------------------------------------------------------------
#  Una foto viene tagliata in tante tessere (3x3 o 4x4). Una
#  tessera manca: resta un buco. Clicchi una tessera vicino al
#  buco e questa ci scivola dentro. Obiettivo: rimettere in
#  ordine le tessere e RICOMPORRE la foto.
#
#  All'avvio scegli la TUA foto (dal computer) o quella di
#  esempio, e la difficolta' (3x3 facile, 4x4 classico).
#  Le tessere hanno una cornice in stile LEGNO.
#
#  Extra utili:
#   - un'ANTEPRIMA in alto a destra (il "coperchio della scatola"):
#     guardi il modello e sai dove va ogni pezzo.
#   - un interruttore "Mostra i numeri": chi vuole aiuto lo accende,
#     chi vuole la sfida lo tiene spento.
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
var _numeri := {}               # indice tessera -> Label col numero
var _mostra_numeri: bool = false
var _mosse: int = 0
var _vinto: bool = false
var _tavola: Control
var _cornice: TextureRect
var _tex_tavolo: Texture2D       # legno del fondo (tavolo)
var _tex_radica: Texture2D       # legno pregiato/radica della cornice
var _hud: Label
var _menu: Control
var _stato_foto: Label
var _fd: FileDialog
var _vitt: Label


func _ready() -> void:
	randomize()
	set_anchors_preset(Control.PRESET_FULL_RECT)
	# Il FONDO: una tavola di legno vero (venature lunghe), generata dal codice.
	_tex_tavolo = _texture_legno(480, 300, 101, false)
	var bg := TextureRect.new()
	bg.texture = _tex_tavolo
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_SCALE
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)
	# Un velo scuro leggero, così il quadro e le scritte risaltano sul legno.
	var velo := ColorRect.new()
	velo.color = Color(0, 0, 0, 0.30)
	velo.set_anchors_preset(Control.PRESET_FULL_RECT)
	velo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(velo)
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

	# --- Il gancio "fallo tuo": mettici la TUA foto ---
	var tuo := Label.new()
	tuo.text = "Mettici la TUA foto: un tuo meme, un compagno, te stesso!"
	tuo.add_theme_font_size_override("font_size", 22)
	tuo.add_theme_color_override("font_color", Color(1.0, 0.82, 0.35))
	tuo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(tuo)

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


func _texture_legno(w: int, h: int, semi: int, radica: bool) -> Texture2D:
	# Disegna un legno pregiato dal nulla: niente foto da scaricare.
	#  - radica = true  -> venature che vorticano, gli "occhi" della radica (cornice)
	#  - radica = false -> venature lunghe, come una tavola (fondo/tavolo)
	var fig := FastNoiseLite.new()
	fig.seed = semi
	fig.noise_type = FastNoiseLite.TYPE_SIMPLEX
	fig.fractal_type = FastNoiseLite.FRACTAL_FBM
	fig.fractal_octaves = 4
	if radica:
		fig.frequency = 0.012
		fig.domain_warp_enabled = true
		fig.domain_warp_amplitude = 55.0
		fig.domain_warp_frequency = 0.012
	else:
		fig.frequency = 0.010
		fig.domain_warp_enabled = true
		fig.domain_warp_amplitude = 12.0
		fig.domain_warp_frequency = 0.05

	var grana := FastNoiseLite.new()
	grana.seed = semi + 17
	grana.noise_type = FastNoiseLite.TYPE_SIMPLEX
	grana.frequency = 0.09

	# Colori del legno pregiato: dal cioccolato scuro all'ambra dorata.
	var scuro := Color(0.18, 0.085, 0.04)
	var medio := Color(0.43, 0.23, 0.10)
	var chiaro := Color(0.72, 0.48, 0.24)

	var img := Image.create(w, h, false, Image.FORMAT_RGB8)
	for y in h:
		for x in w:
			var a := fig.get_noise_2d(float(x), float(y))
			var g := grana.get_noise_2d(float(x), float(y))
			var v: float
			if radica:
				# tante venature che seguono i vortici: gli occhi della radica
				v = sin(a * 7.0 + g * 1.5) * 0.5 + 0.5
			else:
				# venature lunghe quasi orizzontali, come le assi di un tavolo
				v = sin((float(y) + a * 60.0) * 0.14 + g) * 0.5 + 0.5
			v = clamp(v + g * 0.08, 0.0, 1.0)
			var col: Color
			if v < 0.5:
				col = scuro.lerp(medio, v * 2.0)
			else:
				col = medio.lerp(chiaro, (v - 0.5) * 2.0)
			img.set_pixel(x, y, col)
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
	_crea_anteprima()
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
	# Interruttore "Mostra i numeri": aiuto acceso/spento.
	var cb := CheckButton.new()
	cb.text = "Mostra i numeri"
	cb.position = Vector2(250, 48)
	cb.button_pressed = _mostra_numeri
	cb.toggled.connect(_su_numeri)
	add_child(cb)


func _su_numeri(acceso: bool) -> void:
	_mostra_numeri = acceso
	_applica_numeri()


func _applica_numeri() -> void:
	for indice in _numeri:
		if is_instance_valid(_numeri[indice]):
			_numeri[indice].visible = _mostra_numeri


func _crea_tavola() -> void:
	var vp := get_viewport_rect().size
	var lato := minf(vp.x, vp.y) * 0.80
	_cella = lato / _n
	_origine = Vector2((vp.x - lato) / 2.0, (vp.y - lato) / 2.0 + 24.0)

	# Cornice in RADICA (legno pregiato) attorno al quadro.
	if _tex_radica == null:
		_tex_radica = _texture_legno(360, 360, 202, true)
	var m := _cella * 0.18
	# Un sottile bordo scuro sotto, per dare profondità alla cornice.
	var ombra := ColorRect.new()
	ombra.color = Color(0.05, 0.03, 0.02)
	ombra.position = _origine - Vector2(m, m) - Vector2(3, 3)
	ombra.size = Vector2(lato, lato) + Vector2(m, m) * 2.0 + Vector2(6, 6)
	ombra.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(ombra)

	_cornice = TextureRect.new()
	_cornice.texture = _tex_radica
	_cornice.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_cornice.stretch_mode = TextureRect.STRETCH_SCALE
	_cornice.position = _origine - Vector2(m, m)
	_cornice.size = Vector2(lato, lato) + Vector2(m, m) * 2.0
	_cornice.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_cornice)

	_tavola = Control.new()
	_tavola.position = _origine
	_tavola.size = Vector2(lato, lato)
	add_child(_tavola)


func _crea_anteprima() -> void:
	# Il "coperchio della scatola": la foto intera in piccolo, in alto a destra.
	var vp := get_viewport_rect().size
	var d := minf(vp.x, vp.y) * 0.18   # lato dell'anteprima

	var box := Panel.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = COL_CORNICE
	sb.set_corner_radius_all(8)
	box.add_theme_stylebox_override("panel", sb)
	box.position = Vector2(vp.x - d - 26.0, 20.0)
	box.size = Vector2(d, d)
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(box)

	var b := d * 0.08
	var foto := TextureRect.new()
	# Mostra la stessa porzione quadrata che usiamo per le tessere.
	var tw := _tex.get_width()
	var th := _tex.get_height()
	var side := mini(tw, th)
	var at := AtlasTexture.new()
	at.atlas = _tex
	at.region = Rect2((tw - side) / 2.0, (th - side) / 2.0, side, side)
	foto.texture = at
	foto.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	foto.stretch_mode = TextureRect.STRETCH_SCALE
	foto.position = Vector2(b, b)
	foto.size = Vector2(d - 2.0 * b, d - 2.0 * b)
	foto.mouse_filter = Control.MOUSE_FILTER_IGNORE
	box.add_child(foto)

	var etich := Label.new()
	etich.text = "Modello"
	etich.add_theme_font_size_override("font_size", 16)
	etich.add_theme_color_override("font_color", Color(0.95, 0.92, 0.85))
	etich.position = Vector2(vp.x - d - 26.0, 20.0 + d + 2.0)
	add_child(etich)


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
	_numeri.clear()

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
	_applica_numeri()
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

	# Il numero della tessera (1, 2, 3...): nascosto se l'aiuto è spento.
	var num := Label.new()
	num.text = str(indice + 1)
	num.add_theme_font_size_override("font_size", maxi(16, int(_cella * 0.34)))
	num.add_theme_color_override("font_color", Color(1, 1, 1))
	num.add_theme_color_override("font_outline_color", Color(0, 0, 0))
	num.add_theme_constant_override("outline_size", 6)
	num.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	num.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	num.size = Vector2(_cella, _cella)
	num.mouse_filter = Control.MOUSE_FILTER_IGNORE
	num.visible = _mostra_numeri
	pan.add_child(num)
	_numeri[indice] = num

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
	_applica_numeri()

	_festa()

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


func _festa() -> void:
	# Un'onda di luce che attraversa le tessere in diagonale: piccola festa.
	var oro := Color(1.5, 1.3, 0.7)   # oltre 1 = più luminoso
	for pos in range(_n * _n):
		var indice: int = _board[pos]
		if not _tessere.has(indice):
			continue
		var t: Panel = _tessere[indice]
		var ritardo := (pos % _n + int(pos / _n)) * 0.06
		var tw := create_tween()
		tw.tween_interval(ritardo)
		tw.tween_property(t, "modulate", oro, 0.15)
		tw.tween_property(t, "modulate", Color.WHITE, 0.30)


func _aggiorna_testo() -> void:
	if _hud == null:
		return
	if _vinto:
		_hud.text = "Fatto! Foto ricomposta in %d mosse." % _mosse
	else:
		_hud.text = "Mosse: %d   ·   rimetti in ordine la foto" % _mosse


func _torna_menu() -> void:
	get_tree().reload_current_scene()
