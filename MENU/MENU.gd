extends Control

func _ready():
	$NinePatchRect/INICIAR.grab_focus()
	
func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://JOGO/HELENA.tscn")

func _on_opções_pressed():
	get_tree().change_scene_to_file("res://MENU/MENU_CONTROLE.tscn")

func _on_sair_pressed():
	get_tree().quit()

func _on_novo_jogo_pressed():
	get_tree().change_scene_to_file("res://JOGO/HELENA.tscn")
