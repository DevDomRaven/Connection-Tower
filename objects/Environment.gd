extends Node2D

var turret_cursor = load("res://global/turret_cursor.png")
var wire_cursor = load("res://global/wire_cursor.png")

const square_enemy = preload("res://enemies/SquareEnemy.tscn")
var left_to_spawn = 40
var spawned = 0
var wave_spawned = false
var time_between = 1
var time_offset = 3
var current_selection = null
var in_round = false
var rounds = {
	1: {"squares": 5, "speed": 50, "health": 50, "modulate": Color(0,1,0)},
	2: {"squares": 12, "speed": 100, "health": 100, "modulate": Color(0,1,0)},
	3: {"squares": 15, "speed": 100, "health": 100, "modulate": Color(0,1,0)},
	4: {"squares": 20, "speed": 300, "health": 100, "modulate": Color(0,1,1)},
	5: {"squares": 25, "speed": 400, "health": 100, "modulate": Color(0,1,1)},
	6: {"squares": 25, "speed": 400, "health": 100, "modulate": Color(0,1,1)},
	7: {"squares": 25, "speed": 400, "health": 200, "modulate": Color(1,0,0)},
	8: {"squares": 25, "speed": 400, "health": 200, "modulate": Color(1,0,0)},
	9: {"squares": 25, "speed": 400, "health": 200, "modulate": Color(1,0,0)},
	10: {"squares": 50, "speed": 400, "health": 200, "modulate": Color(0,0,1)},
	11: {"squares": 25, "speed": 500, "health": 200, "modulate": Color(0,1,0)},
	12: {"squares": 200, "speed": 500, "health": 200, "modulate": Color(0,1,0)},
	13: {"squares": 400, "speed": 600, "health": 200, "modulate": Color(0,1,0)},
	14: {"squares": 500, "speed": 500, "health": 200, "modulate": Color(0,1,1)},
	15: {"squares": 600, "speed": 600, "health": 200, "modulate": Color(0,1,1)},
	16: {"squares": 700, "speed": 600, "health": 200, "modulate": Color(0,1,1)},
	17: {"squares": 800, "speed": 600, "health": 200, "modulate": Color(1,0,0)},
	18: {"squares": 900, "speed": 600, "health": 300, "modulate": Color(1,0,1)},
	19: {"squares": 1000, "speed": 600, "health": 300, "modulate": Color(1,0,1)},
	20: {"squares": 1000, "speed": 600, "health": 300, "modulate": Color(1,0,1)}
}

var curr_round = 1
func _ready():
	pass

func create_enemy(speed):
	var new_enemy = square_enemy.instance()
	new_enemy.speed = speed
	new_enemy.health = rounds[curr_round].health
	new_enemy.difficult_colour = rounds[curr_round].modulate
	new_enemy.position = $Navigation2D/Spawn.position
	$Navigation2D.add_child(new_enemy)

func _process(delta):
	if in_round:
		left_to_spawn = rounds[curr_round].squares
		if left_to_spawn > 0:
			if time_between > 0:
				time_between -= time_offset * delta
			else:
				spawned += 1
				create_enemy(rounds[curr_round].speed)
				time_between = 1
				left_to_spawn -= 1
		if spawned == rounds[curr_round].squares:
			spawned = 0
			curr_round += 1
			in_round = false
			end_round()

func end_round():
	GameSettings.current_wave = curr_round
	get_parent().get_node("GUI/BuildButton").show()

func toggle_build_menu():
	var build_container = get_parent().get_node("GUI/Build")
	build_container.visible = not build_container.visible
	
	var play_container = get_parent().get_node("GUI/Play")
	play_container.visible = not play_container.visible
	
	if play_container.visible == true:
		current_selection = null

func build_mode():
	toggle_build_menu()
	$HighlightedDrop.visible = not $HighlightedDrop.visible

func _on_Button_button_down_turret():
	current_selection = 0
	Input.set_custom_mouse_cursor(turret_cursor)

func _on_Next_Round_button_down():
	in_round = true

func _on_BuildButton_button_down():
	var build_button_label = get_parent().get_node("GUI/BuildButton/Label")
	if build_button_label.text == "Done":
		build_button_label.text = "Connection Mode" 
	else:
		build_button_label.text = "Done" 
	build_mode()


func _on_Hwire_button_down():
	current_selection = 2
	Input.set_custom_mouse_cursor(wire_cursor)
	pass # Replace with function body.


func _on_End_body_entered(body):
	# Exit
	
	if body is SquareEnemy:
		get_parent().get_node("Damaged").play(0)
		GameSettings.health -= 25
		body.queue_free()
