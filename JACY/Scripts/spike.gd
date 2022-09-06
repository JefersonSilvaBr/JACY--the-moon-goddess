extends Area2D

func _on_spike_body_entered(body):
	if(body.name == 'Player'):
		$AnimatedSprite.play('active')


func _on_AnimatedSprite_animation_finished():
	var ani_name = $AnimatedSprite.animation
	if(ani_name == 'active'):
		get_tree().change_scene("res://Scenes/GameOver.tscn")
