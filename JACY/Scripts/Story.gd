extends Control

var currentStory = 0
enum{ STORY1, STORY2, STORY3, STORY4 }

func _process(delta):
	match currentStory:
		STORY1:
			$ColorRect/story1.visible = true
			$ColorRect/story2.visible = false
			$ColorRect/story3.visible = false
			$ColorRect/story4.visible = false
			if Input.is_action_just_pressed("ui_right"):
				currentStory = STORY2
			elif Input.is_action_just_pressed("ui_left"):
				get_tree().change_scene("res://Scenes/Menu.tscn")
		STORY2:
			$ColorRect/story1.visible = false
			$ColorRect/story2.visible = true
			$ColorRect/story3.visible = false
			$ColorRect/story4.visible = false
			if Input.is_action_just_pressed("ui_right"):
				currentStory = STORY3
			elif Input.is_action_just_pressed("ui_left"):
				currentStory = STORY1
		STORY3:
			$ColorRect/story1.visible = false
			$ColorRect/story2.visible = false
			$ColorRect/story3.visible = true
			$ColorRect/story4.visible = false
			if Input.is_action_just_pressed("ui_right"):
				currentStory = STORY4
			elif Input.is_action_just_pressed("ui_left"):
				currentStory = STORY2
		STORY4:
			$ColorRect/story1.visible = false
			$ColorRect/story2.visible = false
			$ColorRect/story3.visible = false
			$ColorRect/story4.visible = true
			if Input.is_action_just_pressed("ui_right"):
				get_tree().change_scene("res://Scenes/Fase1.tscn")
			elif Input.is_action_just_pressed("ui_left"):
				currentStory = STORY3
