extends MarginContainer

var turret_cursor = load("res://global/turret_cursor.png")
var wire_cursor = load("res://global/wire_cursor.png")

onready var _toolbox = $TopMenu/MarginContainer/HBoxContainer/Left/Buttons/Toolbox

func _on_Build_button_down():
	if !_toolbox.visible:
		_toolbox.show()
	else:
		_toolbox.hide()

func _on_NextWave_button_down():
	GameSettings.in_round = true


func _on_Wires_button_down():
	GameSettings.build_selection = 1
	Input.set_custom_mouse_cursor(wire_cursor)

func _on_Turret01_button_down():
	GameSettings.build_selection = 0
	Input.set_custom_mouse_cursor(turret_cursor)
	
