extends Node2D
class_name Helena

const _DIALOG_SCREEN: PackedScene = preload("res://JOGO/Dialog/DialogScreen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Olá! Sou o Carinha, seu guia neste jogo. Vamos aprender como jogar!",
		"title": "Carinha"
	},
	1: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Para começar, vamos aprender a nos movimentar pelo cenário.",
		"title": "Carinha"
	},
	2: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Use a tecla W para andar para cima e a tecla S para andar para baixo.",
		"title": "Carinha"
	},
	3: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Para mover-se para os lados, use a tecla A para a esquerda e a tecla D para a direita.",
		"title": "Carinha"
	},
	4: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Pressione SHIFT junto com qualquer tecla de movimento (W, A, S, D) para correr.",
		"title": "Carinha"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

var _dialog_instance: DialogScreen = null
var tutorial_shown = false  # Variável de estado local para o tutorial

func _ready() -> void:
	# Atualize o caminho para seu CanvasLayer
	if _hud == null:
		_hud = get_node("HUD")
	
	# Carregar estado do tutorial (se necessário)
	tutorial_shown = load_tutorial_state()

	# Verifica se o tutorial já foi mostrado
	if not tutorial_shown:
		show_dialog()
		tutorial_shown = true  # Atualiza o estado para evitar mostrar novamente
		save_tutorial_state(tutorial_shown)  # Salvar o estado

func show_dialog() -> void:
	if _dialog_instance == null:
		_dialog_instance = _DIALOG_SCREEN.instantiate()
		_dialog_instance.data = _dialog_data
		_hud.add_child(_dialog_instance)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance_dialog") and _dialog_instance == null:
		show_dialog()

# Funções para carregar e salvar o estado do tutorial
func save_tutorial_state(state: bool) -> void:
	var file = FileAccess.open("user://tutorial_state.save", FileAccess.WRITE)
	if file:
		file.store_line(str(state))
		file.close()

func load_tutorial_state() -> bool:
	var file = FileAccess.open("user://tutorial_state.save", FileAccess.READ)
	if file:
		var line = file.get_line()
		file.close()
		return line == "True"
	return false
