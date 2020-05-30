extends KinematicBody2D

const bullet = preload("res://objects/Bullet.tscn")
onready var barrel = get_node("Barrel")
var turret_speed = 1
var upgrade = 4
var default_turret_speed = 1
var next_enemies = []

# This disables the turret!
var power = false
var adjacent_tiles = {
	"left": false,
	"right": false,
	"up": false,
	"down": false
}

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body is SquareEnemy:
		next_enemies.append(body)

func _process(delta):
	if power:
		if next_enemies:
			if weakref(next_enemies[0]).get_ref():
				get_node("Gun").look_at(next_enemies[0].global_position)
				if turret_speed > 0:
					turret_speed -= delta * upgrade
				else:
					shoot()
					turret_speed = default_turret_speed

func remove_focused():
	next_enemies.remove(0)
	
		
func _on_Area2D_body_exited(body):
	remove_focused()
	
func shoot():
	get_node("AudioStreamPlayer2D").play(0)
	var new_bullet = bullet.instance()
	new_bullet._shoot(next_enemies[0], barrel.global_position)
	add_child(new_bullet)
	
