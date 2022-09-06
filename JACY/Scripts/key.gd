extends Area2D

export var type = 1
signal get_key(type)
signal set_key(type)

func _ready():
	connect("get_key", get_parent().get_node("CanvasLayer/HBoxContainer/Holder"), "on_get_key")
	connect("set_key", get_parent().get_node("door"), "on_set_key")
	emit_signal("get_key", 0)
	emit_signal("set_key", 0)
	match type:
		1:
			$AnimatedSprite.play("key1")
		2:
			$AnimatedSprite.play("key2")
		3:
			$AnimatedSprite.play("key3")
		4:
			$AnimatedSprite.play("key4")

func _on_key_body_entered(body):
	if body.name == "Player":
		emit_signal("get_key", type)
		emit_signal("set_key", type)
		queue_free()
