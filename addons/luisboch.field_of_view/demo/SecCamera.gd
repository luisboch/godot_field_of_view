tool
extends Node2D

export var state = 0 setget _set_state;

export(Color) var color_0 = Color.blue setget set_color_0
export(Color) var color_1 = Color.yellow setget set_color_1
export(Color) var color_2 = Color.red setget set_color_2
export(int) var fov = 60 setget _set_fov
export(int) var view_dist = 500 setget _set_view_distance
export (Vector2) var size = Vector2(96.0, 96.0) setget _set_size;

func _set_fov(val):
	fov = val
	$FOV.field_of_view = val
	
func _set_view_distance(val):
	view_dist = val
	$FOV.warn_distance = val 
	$FOV.danger_distance = val * 0.6
	

func _set_state(val):
	# listen all state updates, and force this node to redrawn using update when needs.
	# it will call _draw fn after
	var last = state
	
	state = val
	
	# State changed, then we need to draw again.
	if last != state:
		update()
	
func _set_size(val):
	size = val
	update()
	
func set_color_0(val):
	color_0 = val
	update()
	
func set_color_1(val):
	color_1 = val
	update()
	
func set_color_2(val):
	color_2 = val
	update()
	
func _process(delta):
	if not Engine.is_editor_hint():
		# Check for changes...
		if $FOV.in_danger_area.size() > 0:
			_set_state(2)
		elif $FOV.in_warn_area.size() > 0:
			_set_state(1)
		else:
			_set_state(0)


func _draw():
	# when drawing we need to get correct position and color.
	draw_rect(Rect2(Vector2(0.0, 0.0) - size * 0.5, size), get_color())
	
	
func get_color():
	
	if state == 0:
		return color_0;
	elif state == 1:
		return color_1;
		
	return color_2


func _on_FOV_target_enter(obj):
	print("Enter "+str(obj));


func _on_FOV_target_exit(obj):
	print("Exit "+str(obj));


func get_danger():
	return $FOV.in_danger_area
	
func get_warn():
	return $FOV.in_warn_area
	
	
	
