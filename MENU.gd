extends Control

func _on_iniciar_pressed():
	pass # Replace with function body.

func _on_opções_pressed():
	get_tree().change_scene_to_file("res://MENU_CONTROLE.tscn")

func _on_sair_pressed():
	get_tree().quit()
