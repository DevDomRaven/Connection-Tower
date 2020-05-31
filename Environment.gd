extends Node2D

const square_enemy = preload("res://enemies/SquareEnemy.tscn")
var left_to_spawn = 40
var spawned = 0
var wave_spawned = false
var time_between = 1
var time_offset = 3

var rounds = {
	1: {"squares": 2, "speed": 400, "health": 100, "modulate": Color(1,1,1)},
	2: {"squares": 2, "speed": 400, "health": 100, "modulate": Color(1,1,1)},
	3: {"squares": 2, "speed": 400, "health": 100, "modulate": Color(1,1,1)}
}

var curr_round = 1

func create_enemy(speed):
	var new_enemy = square_enemy.instance()
	new_enemy.speed = speed
	new_enemy.health = rounds[curr_round].health
	new_enemy.difficult_colour = rounds[curr_round].modulate
	new_enemy.position = $Navigation2D/Spawn.position
	$Navigation2D.add_child(new_enemy)

func _process(delta):
	if GameSettings.in_round:
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
			GameSettings.in_round = false
			end_round()

func end_round():
	GameSettings.current_wave = curr_round

func _on_End_body_entered(body):	
	if body is SquareEnemy:
		get_parent().get_node("Damaged").play(0)
		GameSettings.health -= 25
		body.queue_free()
