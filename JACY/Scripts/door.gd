extends Area2D

var close1 = true
var close2 = true
var close3 = true
var close4 = true

func _ready():
	$text.visible = false

func _on_door_body_entered(body):
	if(close1 or close2 or close3 or close4):
		$text.visible = true
	else:
		get_tree().change_scene("res://Scenes/final.tscn")

func _on_door_body_exited(body):
	$text.visible = false

func on_set_key(type):
	match type:
		1:
			close1 = false
		2:
			close2 = false
		3:
			close3 = false
		4:
			close4 = false
