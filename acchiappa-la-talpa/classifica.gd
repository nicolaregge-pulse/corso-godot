extends CanvasLayer
# ============================================================================
# CLASSIFICA ONLINE CONDIVISA  (Firebase Realtime Database via REST)
# ----------------------------------------------------------------------------
# Riutilizzabile in tutti i giochi. A fine partita mostra i primi 10 punteggi
# di TUTTI i giocatori (letti dal database online). Se il tuo punteggio entra
# in classifica, ti chiede il nome e lo salva; altrimenti ti dice che non sei
# tra i primi 10. Un pulsante "Rigioca" chiude e fa ripartire il gioco.
#
# Come si usa (dal gioco):
#   var clas := preload("res://classifica.gd").new()
#   clas.gioco = "talpa"            # id del gioco (cartella nel database)
#   clas.etichetta = "talpe"        # come si chiama il punteggio, per le scritte
#   clas.al_rigioco = _ricomincia   # cosa fare quando si preme "Rigioca"
#   add_child(clas)
#   ... a fine partita:  clas.apri(punti)
# ============================================================================

const URL_DB := "https://nicolaregge2-default-rtdb.europe-west1.firebasedatabase.app"
const MAX := 10          # quanti punteggi teniamo in classifica
const NOME_MAX := 12     # lunghezza massima del nome

var gioco: String = "gioco"
var etichetta: String = "punti"
var al_rigioco: Callable = Callable()

var aperta: bool = false

var _http: HTTPRequest
var _fase: String = ""
var _punti: int = 0
var _nome_salvato: String = ""
var _punti_salvati: int = -1
var _lista: Array = []

# --- UI ---
var _sfondo: ColorRect
var _titolo: Label
var _stato: Label
var _riga_nome: HBoxContainer
var _nome_edit: LineEdit
var _ok_btn: Button
var _nome_btn: Button
var _righe: VBoxContainer
var _rigioca_btn: Button


func _ready() -> void:
	layer = 100
	_http = HTTPRequest.new()
	add_child(_http)
	_http.request_completed.connect(_on_http)
	_costruisci_ui()
	visible = false


# ---------------------------------------------------------------------------
# API pubblica
# ---------------------------------------------------------------------------
func apri(punti: int) -> void:
	_punti = punti
	_nome_salvato = ""
	_punti_salvati = -1
	aperta = true
	visible = true
	_titolo.text = "CLASSIFICA"
	_stato.text = "Carico la classifica..."
	_riga_nome.visible = false
	_nome_btn.visible = false
	_rigioca_btn.visible = false
	_svuota_righe()
	_fase = "leggi1"
	_leggi()


func _web() -> bool:
	return OS.has_feature("web")


# ---------------------------------------------------------------------------
# Rete
# ---------------------------------------------------------------------------
func _leggi() -> void:
	var url := "%s/classifica/%s.json?print=pretty" % [URL_DB, gioco]
	_http.request(url)


func _scrivi(nome: String, punti: int) -> void:
	var url := "%s/classifica/%s.json" % [URL_DB, gioco]
	var corpo := JSON.stringify({"nome": nome, "punti": punti})
	_http.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, corpo)


func _on_http(result: int, code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var ok := (result == HTTPRequest.RESULT_SUCCESS) and (code >= 200 and code < 300)
	if _fase == "leggi1":
		if not ok:
			_mostra_offline()
			return
		_lista = _parse_lista(body)
		_dopo_lettura_iniziale()
	elif _fase == "scrivi":
		if not ok:
			_stato.text = "Ops, non sono riuscito a salvare. Riprova."
			_rigioca_btn.visible = true
			return
		_fase = "leggi2"
		_leggi()
	elif _fase == "leggi2":
		if not ok:
			_mostra_offline()
			return
		_lista = _parse_lista(body)
		_mostra_finale()


func _parse_lista(body: PackedByteArray) -> Array:
	var testo := body.get_string_from_utf8()
	var dati = JSON.parse_string(testo)
	var out: Array = []
	if typeof(dati) == TYPE_DICTIONARY:
		for k in dati:
			var v = dati[k]
			if typeof(v) == TYPE_DICTIONARY and v.has("punti"):
				out.append({"nome": str(v.get("nome", "???")), "punti": int(v.get("punti", 0))})
	out.sort_custom(func(a, b): return int(a["punti"]) > int(b["punti"]))
	return out


# ---------------------------------------------------------------------------
# Logica classifica
# ---------------------------------------------------------------------------
func _entra_in_classifica() -> bool:
	if _punti <= 0:
		return false
	if _lista.size() < MAX:
		return true
	return _punti > int(_lista[MAX - 1]["punti"])


func _dopo_lettura_iniziale() -> void:
	if _entra_in_classifica():
		_titolo.text = "SEI TRA I PRIMI 10!"
		_stato.text = "Hai fatto %d %s. Salva il tuo nome:" % [_punti, etichetta]
		# Sul telefono/web usiamo la finestrella di scrittura del browser (la
		# tastiera dentro Godot spesso non compare su Android). Su computer,
		# la casella di testo classica.
		if _web():
			_nome_btn.visible = true
			_riga_nome.visible = false
		else:
			_riga_nome.visible = true
			_nome_edit.text = ""
			_nome_edit.grab_focus()
		_disegna_righe(-1)
		_rigioca_btn.visible = false
	else:
		_titolo.text = "CLASSIFICA"
		_stato.text = "Hai fatto %d %s. Non sei tra i primi 10... riprova!" % [_punti, etichetta]
		_riga_nome.visible = false
		_disegna_righe(-1)
		_rigioca_btn.visible = true


func _on_ok() -> void:
	_salva_nome(_nome_edit.text)


func _on_nome_btn() -> void:
	# Apre la finestrella di scrittura nativa del browser (tastiera vera del
	# telefono). Ritorna il testo, oppure null se l'utente annulla.
	var r = JavaScriptBridge.eval('window.prompt("Sei tra i primi 10! Scrivi il tuo nome (max 12):", "")', true)
	if r == null:
		_nome_btn.visible = false
		_stato.text = "Va bene, non salvato. Ecco i primi 10:"
		_disegna_righe(-1)
		_rigioca_btn.visible = true
		return
	_salva_nome(str(r))


func _salva_nome(testo: String) -> void:
	var nome := testo.strip_edges()
	if nome == "":
		nome = "Anonimo"
	if nome.length() > NOME_MAX:
		nome = nome.substr(0, NOME_MAX)
	_nome_salvato = nome
	_punti_salvati = _punti
	_riga_nome.visible = false
	_nome_btn.visible = false
	_stato.text = "Salvo il tuo punteggio..."
	_fase = "scrivi"
	_scrivi(nome, _punti)


func _mostra_finale() -> void:
	_titolo.text = "CLASSIFICA"
	_stato.text = "Ecco i migliori 10!"
	# trova la posizione della riga appena salvata, per evidenziarla
	var mia := -1
	var contati := 0
	for i in range(_lista.size()):
		if contati >= MAX:
			break
		if mia == -1 and str(_lista[i]["nome"]) == _nome_salvato and int(_lista[i]["punti"]) == _punti_salvati:
			mia = i
		contati += 1
	_disegna_righe(mia)
	_rigioca_btn.visible = true


func _mostra_offline() -> void:
	_titolo.text = "CLASSIFICA"
	_stato.text = "Classifica non disponibile (manca la connessione). Riprova più tardi."
	_svuota_righe()
	_riga_nome.visible = false
	_rigioca_btn.visible = true


func _on_rigioca() -> void:
	aperta = false
	visible = false
	if al_rigioco.is_valid():
		al_rigioco.call()


# ---------------------------------------------------------------------------
# Costruzione grafica
# ---------------------------------------------------------------------------
func _costruisci_ui() -> void:
	_sfondo = ColorRect.new()
	_sfondo.color = Color(0, 0, 0, 0.74)
	_sfondo.set_anchors_preset(Control.PRESET_FULL_RECT)
	_sfondo.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(_sfondo)

	var pannello := PanelContainer.new()
	pannello.set_anchors_preset(Control.PRESET_FULL_RECT)
	pannello.offset_left = 22
	pannello.offset_top = 44
	pannello.offset_right = -22
	pannello.offset_bottom = -44
	var stile := StyleBoxFlat.new()
	stile.bg_color = Color(0.12, 0.12, 0.16, 0.98)
	stile.border_color = Color(1.0, 0.82, 0.25)
	stile.set_border_width_all(3)
	stile.set_corner_radius_all(14)
	stile.set_content_margin_all(18)
	pannello.add_theme_stylebox_override("panel", stile)
	_sfondo.add_child(pannello)

	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 12)
	pannello.add_child(v)

	_titolo = Label.new()
	_titolo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_titolo.add_theme_font_size_override("font_size", 40)
	_titolo.add_theme_color_override("font_color", Color(1.0, 0.82, 0.25))
	_titolo.text = "CLASSIFICA"
	v.add_child(_titolo)

	_stato = Label.new()
	_stato.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_stato.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_stato.add_theme_font_size_override("font_size", 22)
	v.add_child(_stato)

	_riga_nome = HBoxContainer.new()
	_riga_nome.add_theme_constant_override("separation", 10)
	_nome_edit = LineEdit.new()
	_nome_edit.placeholder_text = "Il tuo nome"
	_nome_edit.max_length = NOME_MAX
	_nome_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_nome_edit.add_theme_font_size_override("font_size", 26)
	_nome_edit.text_submitted.connect(func(_t): _on_ok())
	_riga_nome.add_child(_nome_edit)
	_ok_btn = Button.new()
	_ok_btn.text = "OK"
	_ok_btn.focus_mode = Control.FOCUS_NONE
	_ok_btn.add_theme_font_size_override("font_size", 26)
	_ok_btn.pressed.connect(_on_ok)
	_riga_nome.add_child(_ok_btn)
	v.add_child(_riga_nome)

	_nome_btn = Button.new()
	_nome_btn.text = "✍  Scrivi il tuo nome"
	_nome_btn.focus_mode = Control.FOCUS_NONE
	_nome_btn.add_theme_font_size_override("font_size", 28)
	_nome_btn.custom_minimum_size = Vector2(0, 54)
	_nome_btn.pressed.connect(_on_nome_btn)
	_nome_btn.visible = false
	v.add_child(_nome_btn)

	_righe = VBoxContainer.new()
	_righe.add_theme_constant_override("separation", 4)
	_righe.size_flags_vertical = Control.SIZE_EXPAND_FILL
	v.add_child(_righe)

	_rigioca_btn = Button.new()
	_rigioca_btn.text = "Rigioca"
	_rigioca_btn.focus_mode = Control.FOCUS_NONE
	_rigioca_btn.add_theme_font_size_override("font_size", 30)
	_rigioca_btn.custom_minimum_size = Vector2(0, 56)
	_rigioca_btn.pressed.connect(_on_rigioca)
	v.add_child(_rigioca_btn)


func _svuota_righe() -> void:
	for c in _righe.get_children():
		c.queue_free()


func _disegna_righe(evidenzia: int) -> void:
	_svuota_righe()
	if _lista.is_empty():
		var vuoto := Label.new()
		vuoto.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vuoto.add_theme_font_size_override("font_size", 22)
		vuoto.text = "Ancora nessun punteggio. Sii il primo!"
		_righe.add_child(vuoto)
		return
	var n: int = min(_lista.size(), MAX)
	for i in range(n):
		var riga := HBoxContainer.new()
		riga.add_theme_constant_override("separation", 8)
		var e := (i == evidenzia)
		var col := Color(1.0, 0.9, 0.4) if e else Color(0.92, 0.92, 0.92)
		var pos := Label.new()
		pos.custom_minimum_size = Vector2(46, 0)
		pos.add_theme_font_size_override("font_size", 24)
		pos.add_theme_color_override("font_color", col)
		pos.text = "%d." % (i + 1)
		riga.add_child(pos)
		var nom := Label.new()
		nom.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		nom.add_theme_font_size_override("font_size", 24)
		nom.add_theme_color_override("font_color", col)
		nom.text = (str(_lista[i]["nome"]) + "  ◄ TU") if e else str(_lista[i]["nome"])
		riga.add_child(nom)
		var pun := Label.new()
		pun.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		pun.custom_minimum_size = Vector2(70, 0)
		pun.add_theme_font_size_override("font_size", 24)
		pun.add_theme_color_override("font_color", col)
		pun.text = str(int(_lista[i]["punti"]))
		riga.add_child(pun)
		_righe.add_child(riga)
