extends Area2D

var add_life = 6
signal add_life(add_life)

func _ready():
	connect("add_life", get_parent().get_node("Player"), "on_add_life")

func _on_bonfire_body_entered(body):
	if(body.name == 'Player') and $AnimatedSprite.animation == "color1":
		$AnimatedSprite.play('color2')
		emit_signal("add_life" , add_life)

