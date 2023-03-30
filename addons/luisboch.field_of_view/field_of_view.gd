@tool
extends Node2D

@export var field_of_view = 60: 
	set(value):
		field_of_view = value
		update_view()
			
@export var warn_distance = 500:
	set(value):
		warn_distance = value
		update_view()
		
@export var danger_distance = 200:
	set(value):
		danger_distance = value
		update_view()
		
@export var show_fov = true:
	set(value):
		show_fov = value
		update_view()
		
@export var show_target_line = true

@export var fov_color = Color.GREEN:
	set(value):
		fov_color = value
		update_view()
		
@export var fov_warn_color = Color.YELLOW:
	set(value):
		fov_warn_color = value
		update_view()
		
@export var fov_danger_color = Color.RED:
	set(value): 
		fov_danger_color = value
		update_view()

@export var view_detail = 60:
	set(value):
		view_detail = value
		update_view()
		
@export var target_groups = ["Enemy"]

@export_flags_2d_physics var collision_mask = 1:
	set(value):
		collision_mask = value
		update_view()

signal target_enter
signal target_exit

var in_danger_area = []
var in_warn_area = []

# Buffer to target points
var points_arc = []

@export var frequency = 0.5:
	set(value):
		frequency = value
		update_view()
		
var timer

var dir_deg
var start_angle
var end_angle

func _enter_tree():
	if not Engine.is_editor_hint():
		timer = Timer.new()
		timer.connect("timeout", check_view)
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
	if not in_danger_area.is_empty():
		color = fov_danger_color
	elif not in_warn_area.is_empty():
		color = fov_warn_color
	else:
		color = fov_color
		
	for aux in points_arc:
		draw_line(get_position(), aux.pos , color)

func deg_to_vector(deg):
	return Vector2( cos(deg_to_rad(deg)), sin(deg_to_rad(deg)) )


func create_draw_points():
	points_arc = []
	if view_detail <= 0:
		super.queue_redraw()
		return
		
	var angles = []
	var step = float(field_of_view) / float(view_detail)
	if start_angle != null:
		for i in range(view_detail):
			var cur_angle = float(start_angle) + (float(i) * float(step)) + (float(step) * 0.5)
			var point = get_position() + deg_to_vector(cur_angle) * warn_distance
			points_arc.append({"pos": point, "level": 0})
	super.queue_redraw()

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
		
		var result = space_state.intersect_ray(
			PhysicsRayQueryParameters2D.create(
				get_global_transform().origin,
				to_global(tg_point.pos),
				collision_mask, 
				[get_parent()]
			)
		)
		
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
	
func update_view():
	_update_rotation()
	create_draw_points()

func _set_frequency(val):
	frequency = val
	if timer:
		timer.wait_time = val
		timer.start(val)
	

