extends Node2D

var power = false
var x
var y
var checked = false
var sprite = "default"
var adjacent_tiles = {
	"left": false,
	"right": false,
	"up": false,
	"down": false
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_x_y(nx, ny):
	x = nx
	y = ny

func _process(delta):

	if power == true:
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == false:
			sprite = "4"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "1"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "hor_enabled"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "7"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "9"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "5"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "8"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "6"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "3"
		if adjacent_tiles.left == false && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "2"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "ver_enabled"
		$Wire.play(sprite)
	else:
		print('DISABLED')
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == false:
			sprite = "4d"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "1d"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "hor_disabled"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "7d"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "9d"
		if adjacent_tiles.left == true && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "5d"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "8d"
		if adjacent_tiles.left == true && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "6d"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == false && adjacent_tiles.right == true:
			sprite = "3d"
		if adjacent_tiles.left == false && adjacent_tiles.down == false && adjacent_tiles.up == true && adjacent_tiles.right == true:
			sprite = "2d"
		if adjacent_tiles.left == false && adjacent_tiles.down == true && adjacent_tiles.up == true && adjacent_tiles.right == false:
			sprite = "ver_disabled"
		$Wire.play(sprite)

