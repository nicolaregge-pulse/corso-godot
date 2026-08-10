extends Node2D
# ESERCIZIO 1 — Il bottone che saluta.
# Consegna di Mario Rossi, 1 Informatica.

@onready var bottoneVar: Button = $bottoneScena
@onready var etichettaVar: Label = $etichettaScena

func _ready() -> void:
	bottoneVar.position = Vector2(100, 100)
	# IL MIO TOCCO: la scritta dentro al bottone
	bottoneVar.text = "Premi qui"
	etichettaVar.position = Vector2(100, 180)
	etichettaVar.text = "..."
	# IL MIO TOCCO: scritta verde (i numeri vanno da 0 a 1, non da 0 a 255)
	etichettaVar.add_theme_color_override("font_color", Color(0, 1, 0))
	bottoneVar.pressed.connect(_quando_premo)

func _quando_premo() -> void:
	# IL MIO TOCCO: il mio saluto
	etichettaVar.text = "Ciao Mario, bella lì!"
