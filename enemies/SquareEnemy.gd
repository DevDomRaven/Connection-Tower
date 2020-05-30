extends KinematicBody2D

class_name SquareEnemy
var health = 100
var path = []
onready var target = get_parent().get_node("Endpoint")
var speed = 80
var velocity = Vector2()
var difficult_colour = Color(0,1,0)

func _ready():
	$AnimatedSprite.modulate = difficult_colour
	pass # Replace with function body.
	
func move_along_path(distance):
	var last_point = position
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			var new_position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			look_at(new_position)
			position = new_position
			move_and_collide(Vector2(0.0, 0.0))
			return position
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	position = last_point
	move_and_collide(Vector2(0.0, 0.0))
	return position
	set_process(false)
	
func _physics_process(delta):
	if target:
		path = get_parent()._update_navigation_path(position, target.position)
		velocity = move_along_path(speed * delta)
