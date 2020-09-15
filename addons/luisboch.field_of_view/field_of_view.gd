tool
extends Node2D

export var field_of_view = 60 setget _set_field_of_view
export var warn_distance = 500 setget _set_warn_distance
export var danger_distance = 200 setget _set_danger_distance

export var show_fov = true setget _set_show_fov
export var show_target_line = true

export var fov_color = Color("#b23d7f0b") setget _set_fov_color
export var fov_warn_color = Color("#b1eedf0b") setget _set_fov_warn_color
export var fov_danger_color = Color("#9dfb320b") setget _set_fov_danger_color

export var view_detail = 60  setget _set_view_detail

export var target_groups = ["Enemy"]

export(int, LAYERS_2D_PHYSICS) var collision_mask = 1 setget _set_collision_mask

signal target_enter
signal target_exit

var in_danger_area = []
var in_warn_area = []

# Buffer to target points
var points_arc = []

export var frequency = 0.5 setget _set_frequency
var timer

var dir_deg
var start_angle
var end_angle

func _enter_tree():
	if not Engine.is_editor_hint():
		timer = Timer.new()
		timer.connect("timeout", self, "check_view")
		timer.one_shot = false
		timer.autostart = true
		call_deferred("setup_timer")
		call_deferred("_set_frequency", frequency)
	_update_rotation()

func _ready():
	update_view()
	

func setup_timer():
	add_child(timer)
	timer.owner = self
	timer.wait_time = frequency
	
func _draw():
	if show_fov:
		draw_fov()

func draw_fov():
	var color 
	if not in_danger_area.empty():
		color = fov_danger_color
	elif not in_warn_area.empty():
		color = fov_warn_color
	else:
		color = fov_color
		
	for aux in points_arc:
		draw_line(get_position(), aux.pos , color)

func deg_to_vector(deg):
	return Vector2( cos(deg2rad(deg)), sin(deg2rad(deg)) )


func create_draw_points():
	points_arc = []
	if view_detail <= 0:
		update()
		return
		
	var angles = []
	var step = float(field_of_view) / float(view_detail)
	if start_angle != null:
		for i in range(view_detail):
			var cur_angle = float(start_angle) + (float(i) * float(step)) + (float(step) * 0.5)
			var point = get_position() + deg_to_vector(cur_angle) * warn_distance
			points_arc.append({"pos": point, "level": 0})
	update()

func check_view():
	create_draw_points()
	var original_objs =  []
	original_objs += in_danger_area
	original_objs += in_warn_area
	
	in_danger_area = []
	in_warn_area = []
	
	if not get_world_2d():
		## Not available (maybe it is editor only)
		return;

	var space_state = get_world_2d().direct_space_state

	for tg_point in points_arc:
		# use global coordinates, not local to node
		tg_point.level = 0
		
		var result = space_state.intersect_ray(get_global_transform().origin, to_global(tg_point.pos), [get_parent()], collision_mask)
		
		if not result: 
			continue
			
		if result:
			
			var local_pos = to_local(result.position)
			var dist = get_position().distance_to(local_pos)
			var level = 0
			var is_target = false
			tg_point.pos = local_pos
			
			# Has been seen in previous loop
			if in_danger_area.has(result.collider) || in_warn_area.has(result.collider):
				tg_point.level = level
				continue
				
			for g in target_groups :
				if result.collider.get_groups().has(g):
					is_target = true
			tg_point.level = 0
			
			
			if is_target:
				level = 1
				if dist < danger_distance :
					level = 2
					in_danger_area.append(result.collider)
				else :
					in_warn_area.append(result.collider)
				
				if show_target_line:
					var tgt_pos = result.collider.get_global_transform().origin
					points_arc.append({"pos": to_local(tgt_pos), "level": level})
					
	_update_events(original_objs)


func _update_events(original):
	for obj in original:
		if obj in in_danger_area or obj in in_warn_area:
			continue
			
		emit_signal("target_exit", obj)
	var all = in_danger_area + in_warn_area
	for obj in all:
		if obj in original:
			continue
		emit_signal("target_enter", obj)

func _update_rotation():
	start_angle = -int(field_of_view * 0.5)
	end_angle = int(start_angle + field_of_view)

func _set_field_of_view(val):
	field_of_view = val
	update_view()
	
func _set_show_fov(val):
	show_fov = val
	update_view()
	
func _set_fov_color(val):
	fov_color = val
	update_view()
	
func _set_fov_warn_color(val):
	fov_warn_color = val
	update_view()
	
func _set_fov_danger_color(val):
	fov_danger_color = val
	update_view()

func _set_view_detail(val):
	view_detail = val
	update_view()
func _set_warn_distance(val):
	warn_distance = val
	update_view()
	
func _set_danger_distance(val):
	danger_distance = val
	update_view()


func _set_collision_mask(val):
	collision_mask = val
	update_view()
	
func update_view():
	_update_rotation()
	create_draw_points()

func _set_frequency(val):
	frequency = val
	if timer:
		timer.wait_time = val
		timer.start(val)
	

