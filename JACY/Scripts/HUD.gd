extends Control

func on_change_life(life):
	match life:
		1:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = false
			$"base-full/heart-full3".visible = false
			$"base-full/heart-full4".visible = false
			$"base-full/heart-full5".visible = false
			$"base-full/heart-full6".visible = false
		2:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = true
			$"base-full/heart-full3".visible = false
			$"base-full/heart-full4".visible = false
			$"base-full/heart-full5".visible = false
			$"base-full/heart-full6".visible = false
		3:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = true
			$"base-full/heart-full3".visible = true
			$"base-full/heart-full4".visible = false
			$"base-full/heart-full5".visible = false
			$"base-full/heart-full6".visible = false
		4:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = true
			$"base-full/heart-full3".visible = true
			$"base-full/heart-full4".visible = true
			$"base-full/heart-full5".visible = false
			$"base-full/heart-full6".visible = false
		5:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = true
			$"base-full/heart-full3".visible = true
			$"base-full/heart-full4".visible = true
			$"base-full/heart-full5".visible = true
			$"base-full/heart-full6".visible = false
		6:
			$"base-full/heart-full1".visible = true
			$"base-full/heart-full2".visible = true
			$"base-full/heart-full3".visible = true
			$"base-full/heart-full4".visible = true
			$"base-full/heart-full5".visible = true
			$"base-full/heart-full6".visible = true

func on_get_key(type):
	match type:
		1:
			$"base-full/key1".visible = true
			print(true)
		2:
			$"base-full/key2".visible = true
		3:
			$"base-full/key3".visible = true
		4:
			$"base-full/key4".visible = true
