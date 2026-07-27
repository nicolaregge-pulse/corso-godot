extends Node2D
# ESERCIZIO 1 — Il bottone che saluta (soluzione funzionante).
# Ponte da Lazarus: è il tuo Button1Click che cambia una Caption.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena". Cosi' si capisce a colpo d'occhio chi e' chi.

@onready var bottoneVar: Button = $bottoneScena
@onready var etichettaVar: Label = $etichettaScena

func _ready() -> void:
	# Posizioniamo i due elementi così non si sovrappongono
	bottoneVar.position = Vector2(100, 100)
	bottoneVar.text = "Salutami!"          # <- come Button.Caption in Lazarus
	etichettaVar.position = Vector2(100, 180)
	etichettaVar.text = "..."
	# Colleghiamo il "click" (segnale pressed) alla nostra funzione
	bottoneVar.pressed.connect(_quando_premo)

# Questa e' come il tuo Button1Click di Lazarus
func _quando_premo() -> void:
	etichettaVar.text = "Ciao! Mi hai premuto."
