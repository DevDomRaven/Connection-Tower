extends MarginContainer

onready var _toolbox = $TopMenu/MarginContainer/HBoxContainer/Buttons/Toolbox

func _on_Build_button_down():
	if !_toolbox.visible:
		_toolbox.show()
	else:
		_toolbox.hide()

func _on_NextWave_button_down():
	GameSettings.in_round = true
