extends Node

var money = 10
var health = 100
var current_wave = 1
var in_round = false
var build_menu = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if health <= 0:
		health = 100
		money = 10
		get_tree().reload_current_scene()
		get_tree().change_scene("res://scene/GameOver.tscn")
