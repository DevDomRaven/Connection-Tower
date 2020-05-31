extends TileMap

const turret = preload("res://objects/Turret.tscn")
const power = preload("res://objects/PowerStation.tscn")
const wire = preload("res://objects/Wire.tscn")
var cursor = load("res://global/cursor.png")

onready var Highlight = get_parent().get_node("HighlightedDrop")
onready var SandboxObj = get_parent().get_node("SandboxObj")

var turrets = {}
var powerstations = {}
var wires = {}

func _process(delta):
	process_wires()
	check_turret_power()

# Called when the node enters the scene tree for the first time.
func _ready():
	loop_tilemap_and_replace()
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true and Highlight.visible:
		var mouse_click = get_global_mouse_position()
		var tile = world_to_map(mouse_click)
		
		if Highlight.get_cellv(tile) != -1:
		
			if get_cellv(tile) == -1:
				if turrets.has(tile):
					print(turrets[tile].name)
					
				var selection = GameSettings.build_selection
				if selection != null:
					var purchesed = false
					
					if selection == 0:
						if GameSettings.money >= 5:
							purchesed = true
							GameSettings.money -= 5
					elif selection == 2:
						if GameSettings.money >= 1:
							purchesed = true
							GameSettings.money -= 1
						
					if purchesed:
						#allow to keep adding wires
						if selection == 2:
							set_cellv(tile, selection)
							loop_tilemap_and_replace()
						else:
							set_cellv(tile, selection)
							loop_tilemap_and_replace()
							Input.set_custom_mouse_cursor(cursor)
							get_parent().current_selection = null
					else:
						get_parent().current_selection = null
						Input.set_custom_mouse_cursor(cursor)
						OS.alert("You dont have enough", "No Money")
						
						

func loop_tilemap_and_replace():
	for child in SandboxObj.get_children():
		child.queue_free()
		
	for cell in get_used_cells():
		if get_cellv(cell) == 0:
			#Turret
			var new_turret = turret.instance()
			var world_vec = map_to_world(cell)	
			new_turret.position = Vector2(world_vec.x + 8, world_vec.y + 8)
			turrets[cell] = new_turret
			SandboxObj.add_child(new_turret)
			
		elif get_cellv(cell) == 1:
			#PowerStation
			var new_power = power.instance()
			var world_vec = map_to_world(cell)	
			new_power.position = Vector2(world_vec.x + 8, world_vec.y + 8)
			powerstations[cell] = new_power
			SandboxObj.add_child(new_power)
		elif get_cellv(cell) == 2:
			#wire
			var new_wire = wire.instance()
			var world_vec = map_to_world(cell)	
			new_wire.position = Vector2(world_vec.x + 8, world_vec.y + 8)
			new_wire.set_x_y(cell.x, cell.y)
			wires[cell] = new_wire
			SandboxObj.add_child(new_wire)	
	trigger_power()

func enable_eletric_for(wire, string_pos):
	wires[wire].power = true
	
	if string_pos == "right":
		wires[wire].adjacent_tiles.right = true
	elif string_pos == "left":
		wires[wire].adjacent_tiles.left = true
	elif string_pos == "up":
		wires[wire].adjacent_tiles.up = true
	elif string_pos == "down":
		wires[wire].adjacent_tiles.down = true

func process_wires():
	for power in powerstations.keys():
		wires[power] = powerstations[power]
	
	for turret in turrets.keys():
		wires[turret] = turrets[turret]
	
	for wire in wires.keys():
		if wires[wire].power == true:
				
			var right = Vector2(wire.x+1, wire.y)
			var left = Vector2(wire.x-1, wire.y)
			var up = Vector2(wire.x, wire.y-1)
			var down = Vector2(wire.x, wire.y+1)

			if wires.has(right):
				enable_eletric_for(right, "left")
			if wires.has(left):
				enable_eletric_for(left, "right")
			if wires.has(up):
				enable_eletric_for(up, "down")
			if wires.has(down):
				enable_eletric_for(down, "up")

func trigger_power():
	for power in powerstations.keys():
		
		var right = Vector2(power.x+1, power.y)
		var left = Vector2(power.x-1, power.y)
		var up = Vector2(power.x, power.y-1)
		var down = Vector2(power.x, power.y+1)
		
		if wires.has(left):
			enable_eletric_for(left, "left")
		if wires.has(right):
			enable_eletric_for(right, "right")
		if wires.has(up):
			enable_eletric_for(up, "up")
		if wires.has(down):
			enable_eletric_for(down, "down")
	process_wires()

func check_turret_power():
	for power in powerstations.keys():
		for turret in turrets.keys():
			if turret.x == power.x and turret.y == power.y + 1:
				turrets[turret].get_node("Turret").power = true
			elif turret.x == power.x and turret.y == power.y - 1:
				turrets[turret].get_node("Turret").power = true
			elif turret.x == power.x + 1 and turret.y == power.y:
				turrets[turret].get_node("Turret").power = true
			elif turret.x == power.x - 1 and turret.y == power.y:
				turrets[turret].get_node("Turret").power = true

	for wire in wires.keys():
		if wires[wire] != Turret:
			for turret in turrets.keys():
				if turret.x == wire.x and turret.y == wire.y + 1:
					turrets[turret].get_node("Turret").power = true
				elif turret.x == wire.x and turret.y == wire.y - 1:
					turrets[turret].get_node("Turret").power = true
				elif turret.x == wire.x + 1 and turret.y == wire.y:
					turrets[turret].get_node("Turret").power = true
				elif turret.x == wire.x - 1 and turret.y == wire.y:
					turrets[turret].get_node("Turret").power = true
		

