extends Interactable

class_name susto


@export_category("Objects")
@export var _hud: CanvasLayer = null

var _dialog_instance: DialogScreen = null
var is_diolog_possible = false

func interact(user: Node2D):
	if Input.is_action_just_pressed("INTERACT"):
		if _dialog_instance == null && is_diolog_possible == true:
			is_diolog_possible = false
		else:
			stop_interaction(user)
		Global.sanity_interaction = 1
		


func stop_interaction(user: Node2D):
	if _dialog_instance != null:
		_hud.remove_child(_dialog_instance)
		_dialog_instance.queue_free()
		_dialog_instance = null
	
	
func _on_area_entered(area):
	if _dialog_instance == null && area.name == "AreaDeInteraçãoHelena":
		is_diolog_possible = true
