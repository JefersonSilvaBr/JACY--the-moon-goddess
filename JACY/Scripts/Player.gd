extends KinematicBody2D

const Arrow := preload("res://Scenes/arrow.tscn")

var life = 3
signal change_life(life)

var velocity = Vector2( )
var current_state := 0
enum { IDLE, RUN, FLY, FALL, ATTACK, TRANSIT1, TRANSIT2, FEEDBACK}

func _ready():
	connect("change_life", get_parent().get_node("CanvasLayer/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life" , life)

func _physics_process(delta):
	match current_state:
		IDLE:
			_idle_state(delta)
		RUN:
			_run_state(delta)
		FLY:
			_fly_state(delta)
		FALL:
			_fall_state(delta)
		ATTACK:
			_attack_state(delta)
		TRANSIT1:
			_transit_state(1)
		TRANSIT2:
			_transit_state(2)
		FEEDBACK:
			_feedback_state(delta)


func _idle_state(_delta):
	$Animation.play("idle")
	velocity.x = 0
	_apply_gravity(_delta)
	_move_and_slide()
	current_state = _check_idle_state()

func _run_state(_delta):
	$Animation.play("run")
	_move()
	_apply_gravity(_delta)
	_move_and_slide()
	current_state = _check_run_state()

func _fly_state(_delta):
	$Animation.play("transform")
	if Input.is_action_pressed("ui_trasform"):
		velocity.y = -100
	_move()
	_apply_gravity(_delta)
	_move_and_slide()
	current_state = _check_fly_state()

func _fall_state(_delta):
	_move()
	_apply_gravity(_delta)
	_move_and_slide()
	current_state = _check_fall_state()

func _attack_state(_delta):
	$Animation.play("attack")
	velocity.x = 0
	_move_and_slide()

func _transit_state(type:int):
	if(type == 1):
		$Animation.play("transit")
	else:
		$Animation.play("transit2")

func _feedback_state(_delta):
	$Animation.play("feedback")
	velocity.x = 0
	_move_and_slide()

func _check_idle_state():
	var new_state = current_state
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		new_state = RUN
	elif Input.is_action_pressed("ui_trasform"):
		new_state = TRANSIT1
	elif not is_on_floor():
		new_state = FALL
	elif Input.is_action_just_pressed("ui_shoot"):
		new_state = ATTACK
	return new_state

func _check_run_state():
	var new_state = current_state
	if not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		new_state = IDLE
	elif Input.is_action_pressed("ui_trasform"):
		new_state = TRANSIT1
	elif not is_on_floor():
		new_state = FALL
	elif Input.is_action_just_pressed("ui_shoot"):
		new_state = ATTACK
	return new_state

func _check_fly_state():
	var new_state = current_state
	if is_on_floor():
		new_state = TRANSIT2
	return new_state

func _check_fall_state():
	var new_state = current_state
	if is_on_floor():
		new_state = RUN
	elif Input.is_action_pressed("ui_trasform"):
		new_state = TRANSIT1
	return new_state

func _check_attack_state():
	pass


func _apply_gravity(_delta):
	velocity.y += 800 * _delta
func _move_and_slide():
	velocity = move_and_slide(velocity, Vector2.UP)
func _move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = +80
		$shootPoint.position.x = 12
		$Animation.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -80
		$shootPoint.position.x = -12
		$Animation.flip_h = true


func _on_Animation_animation_finished():
	var ani_name = $Animation.animation
	
	if ani_name == 'attack':
		var arrow_instance = Arrow.instance()
		if $Animation.flip_h:
			arrow_instance._set_direction(-1)
		else:
			arrow_instance._set_direction(1)
		get_parent().add_child(arrow_instance)
		arrow_instance.position = $shootPoint.global_position
		current_state = IDLE
	elif ani_name == 'transit':
		current_state = FLY
	elif ani_name == 'transit2':
		current_state = IDLE
	elif ani_name == 'feedback':
		if life <= 0:
			get_tree().change_scene("res://Scenes/GameOver.tscn")
		else:
			current_state = IDLE

func _on_hitbox_body_entered(body):
	life-=1
	emit_signal("change_life" , life)
	current_state = FEEDBACK
	pass

func on_add_life(add_life):
	life = add_life
	emit_signal("change_life" , life)
