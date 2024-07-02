extends Interactable

const _DIALOG_SCREEN: PackedScene = preload("res://Helena/Objects/Dialog/DialogScreen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://Helena/Assets/Bau.png",
		"dialog": "Baú? Baú, Baú Baú!",
		"title": "Baú Misterioso"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

var _dialog_instance: DialogScreen = null

func interact(user: Node2D):
	if Input.is_action_just_pressed("INTERACT"):
		if _dialog_instance == null:
			show_dialog()
		else:
			stop_interaction(user)


func stop_interaction(user: Node2D):
	if _dialog_instance != null:
		_hud.remove_child(_dialog_instance)
		_dialog_instance.queue_free()
		_dialog_instance = null

func show_dialog() -> void:
	if _dialog_instance == null:
		_dialog_instance = _DIALOG_SCREEN.instantiate()
		_dialog_instance.data = _dialog_data
		_hud.add_child(_dialog_instance)
