extends KinematicBody2D

const Bullet := preload("res://Scenes/bullet.tscn")

var life = 3
var tick = 0
var cooldown = true
var velocity = Vector2( )
export var current_state := 0
var move_dir := 1
enum { RUN, ATTACK, FEEDBACK , CINEMATIC}


func _physics_process(delta):
	match current_state:
		RUN:
			_run_state(delta)
		ATTACK:
			_attack_state(delta)
		FEEDBACK:
			_feedback_state()
		CINEMATIC:
			_cinematic_state(delta)
	
	if not cooldown:
		tick+=1
		if tick >= 60:
			$ray_attack.collide_with_bodies = true
			tick = 0
			cooldown = true
			pass
	

func _run_state(_delta):
	$AnimatedSprite.play("run")
	_move()
	_apply_gravity(_delta)
	_move_and_slide()
	current_state = _check_run_state()

func _cinematic_state(_delta):
	$AnimatedSprite.play("run")
	if move_dir == 1:
		velocity.x = +25
		$shootPoint.position.x = 9
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = -25
		$shootPoint.position.x = -9
		$AnimatedSprite.flip_h = true
	if $ray_wall.is_colliding():
		$ray_wall.scale.x *= -1
		move_dir *= -1
		$ray_attack.scale.x *= -1
		pass
	_move_and_slide()

func _attack_state(_delta):
	$AnimatedSprite.play("attack")
	velocity.x = 0

func _feedback_state():
	$AnimatedSprite.play("feedback")
	velocity.x = 0

func _check_run_state():
	var new_state = current_state
	if $ray_attack.is_colliding():
		cooldown = false
		$ray_attack.collide_with_bodies = false
		new_state = ATTACK
	return new_state

func _apply_gravity(_delta):
	velocity.y += 800 * _delta
func _move_and_slide():
	velocity = move_and_slide(velocity, Vector2.UP)
func _move():
	if move_dir == 1:
		velocity.x = +50
		$shootPoint.position.x = 9
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = -50
		$shootPoint.position.x = -9
		$AnimatedSprite.flip_h = true
	if $ray_wall.is_colliding():
		$ray_wall.scale.x *= -1
		move_dir *= -1
		$ray_attack.scale.x *= -1
		pass


func _on_AnimatedSprite_animation_finished():
	var ani_name = $AnimatedSprite.animation
	if ani_name == 'attack':
		var bullet_instance = Bullet.instance()
		if $AnimatedSprite.flip_h:
			bullet_instance._set_direction(-1)
		else:
			bullet_instance._set_direction(1)
		get_parent().add_child(bullet_instance)
		bullet_instance.position = $shootPoint.global_position
		current_state = RUN
		pass
	elif ani_name == 'feedback':
		if life <= 0:
			queue_free()
		else:
			current_state = RUN

func _on_hitbox_body_entered(body):
	life-=1
	current_state = FEEDBACK
	pass
