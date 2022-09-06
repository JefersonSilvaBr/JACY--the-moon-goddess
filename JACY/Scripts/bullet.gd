extends KinematicBody2D

const SPEED := 200

var velocity := Vector2.ZERO
var direction  := 1

func _set_direction(dir):
	direction = dir
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * direction
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_collider_body_entered(body):
	queue_free()
