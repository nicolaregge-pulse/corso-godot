extends Node2D
# ESERCIZIO 1 — Il bottone che saluta (soluzione funzionante).
# Ponte da Lazarus: è il tuo Button1Click che cambia una Caption.

# $NomeNodo prende un nodo figlio per nome (come riferirsi a Button1 in Lazarus)
@onready var bottone: Button = $BottoneCiao
@onready var etichetta: Label = $Etichetta

func _ready() -> void:
	# Posizioniamo i due elementi così non si sovrappongono
	bottone.position = Vector2(100, 100)
	bottone.text = "Salutami!"          # <- come Button.Caption in Lazarus
	etichetta.position = Vector2(100, 180)
	etichetta.text = "..."
	# Colleghiamo il "click" (segnale pressed) alla nostra funzione
	bottone.pressed.connect(_quando_premo)

# Questa e' come il tuo Button1Click di Lazarus
func _quando_premo() -> void:
	etichetta.text = "Ciao! Mi hai premuto."
