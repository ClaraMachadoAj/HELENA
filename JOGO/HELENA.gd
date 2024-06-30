extends Node2D
class_name Helena

const _DIALOG_SCREEN: PackedScene = preload("res://JOGO/Dialog/DialogScreen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "TESTE DO DIALOGO",
		"title": "Carinha"
	},
	1: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "Os comandos para andar são o WASD",
		"title": "Carinha"
	},
	2: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "W & S para andar na vertical",
		"title": "Carinha"
	},
	3: {
		"faceset": "res://JOGO/Dialog/Assets/CarinhaFeliz.png",
		"dialog": "A & D para andar na horizontal",
		"title": "Carinha"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

var _dialog_instance: DialogScreen = null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance_dialog")and _dialog_instance == null:
		_dialog_instance = _DIALOG_SCREEN.instantiate()
		_dialog_instance.data = _dialog_data
		_hud.add_child(_dialog_instance)
