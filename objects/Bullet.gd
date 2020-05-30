extends Node2D
class_name Bullet


var speed = 300
var damage = 50
var time_alive = 10
var curr_time = 1
var target
var turret

func _shoot(obj, pos):
	#print(get_parent().name)
	target = obj
	turret = pos

func _process(delta):
	if target:
		if weakref(target).get_ref():
			position += (target.global_position - global_position).normalized() * speed * delta
		else:
			queue_free()
			
		
	if curr_time <= time_alive:
		curr_time += delta
	else:
		queue_free()

func _on_Area2D_body_entered(body):
	if body is SquareEnemy:
		body.health -= damage
		if body.health <= 0:
			GameSettings.money += 1
			get_parent().remove_focused()
			body.queue_free()
			queue_free()
		queue_free()
