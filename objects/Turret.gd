extends KinematicBody2D

const bullet = preload("res://objects/Bullet.tscn")
onready var barrel = get_node("Barrel")
var shoot_delay = 1
var upgrade = 5
var default_shoot_delay = 1
var next_enemies = []
var power = false

var adjacent_tiles = {
	"left": false,
	"right": false,
	"up": false,
	"down": false
}

func _process(delta):
	if power:
		if next_enemies:
			if weakref(next_enemies[0]).get_ref():
				get_node("Gun").look_at(next_enemies[0].global_position)
				if shoot_delay > 0:
					shoot_delay -= delta * upgrade
				else:
					shoot()
					shoot_delay = default_shoot_delay

func remove_focused():
	next_enemies.remove(0)
	
func shoot():
	get_node("AudioStreamPlayer2D").play(0)
	var new_bullet = bullet.instance()
	new_bullet._shoot(next_enemies[0], barrel.global_position)
	add_child(new_bullet)
	
func _on_DetectEnemy_body_entered(body):
	if body is SquareEnemy:
		next_enemies.append(body)


func _on_DetectEnemy_body_exited():
	remove_focused()
