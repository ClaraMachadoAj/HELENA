extends Control

func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://JOGO/HELENA.tscn")

func _on_opções_pressed():
	get_tree().change_scene_to_file("res://MENU_CONTROLE.tscn")

func _on_sair_pressed():
	get_tree().quit()
