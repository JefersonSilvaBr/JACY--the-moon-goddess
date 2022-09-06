extends Control


func _on_reply_pressed():
	get_tree().change_scene("res://Scenes/Fase1.tscn")


func _on_menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
