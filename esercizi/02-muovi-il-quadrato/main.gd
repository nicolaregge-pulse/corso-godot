extends Node2D
# ESERCIZIO 2 — Muovi il quadrato (soluzione funzionante).
# Concetto nuovo: il game loop, cioè _process(delta), che gira ~60 volte al secondo.
#
# Convenzione dei nomi: la VARIABILE finisce in "Var", il NODO nella scena
# finisce in "Scena".

@onready var quadratoVar: ColorRect = $quadratoScena
const VELOCITA: float = 300.0   # pixel al secondo

func _ready() -> void:
	quadratoVar.size = Vector2(60, 60)
	quadratoVar.color = Color(0.3, 0.7, 1.0)   # azzurro
	quadratoVar.position = Vector2(200, 200)

# _process gira a OGNI fotogramma: qui muoviamo il quadrato
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		quadratoVar.position.x -= VELOCITA * delta
	if Input.is_action_pressed("ui_right"):
		quadratoVar.position.x += VELOCITA * delta
	if Input.is_action_pressed("ui_up"):
		quadratoVar.position.y -= VELOCITA * delta
	if Input.is_action_pressed("ui_down"):
		quadratoVar.position.y += VELOCITA * delta
