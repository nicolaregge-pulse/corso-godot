extends Node2D
# ESERCIZIO 1 — Il bottone che saluta (soluzione funzionante).
# Ponte da Lazarus: è il tuo Button1Click che cambia una Caption.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

@onready var bottoneVar: Button = $bottoneScena
@onready var etichettaVar: Label = $etichettaScena

func _ready() -> void:
	# Mettiamo il bottone e la scritta in due punti diversi
	bottoneVar.position = Vector2(100, 100)
	bottoneVar.text = "Salutami!"
	etichettaVar.position = Vector2(100, 180)
	etichettaVar.text = "..."
	# FALLO TUO: cambia il colore della scritta (rosso, verde, blu da 0 a 1)
	etichettaVar.add_theme_color_override("font_color", Color(1, 0, 0))
	# Colleghiamo il click del bottone (il segnale "pressed") alla nostra funzione
	bottoneVar.pressed.connect(_quando_premo)

# Questa è come il tuo Button1Click di Lazarus
func _quando_premo() -> void:
	# FALLO TUO: scrivi qui il TUO saluto
	etichettaVar.text = "Ciao! Mi hai premuto."
