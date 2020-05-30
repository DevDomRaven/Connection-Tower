extends Navigation2D

var paths = []

func _update_navigation_path(start_position, end_position):
	paths = get_simple_path(start_position, end_position, false)
	paths.remove(0)
	return paths
