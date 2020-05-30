extends Control

func _process(delta):
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene("res://scenes/World.tscn")
