extends Control

var currentStory = 0
enum{ STORY1, STORY2}

func _process(delta):
	match currentStory:
		STORY1:
			$story1.visible = true
			$story2.visible = false
			$Sprite.visible = false
			if Input.is_action_just_pressed("ui_right"):
				currentStory = STORY2
		STORY2:
			$story1.visible = false
			$story2.visible = true
			$Sprite.visible = true
			if Input.is_action_just_pressed("ui_right"):
				get_tree().change_scene("res://Scenes/Menu.tscn")
			elif Input.is_action_just_pressed("ui_left"):
				currentStory = STORY1
