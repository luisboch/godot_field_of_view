extends KinematicBody2D

export var speed = 200
var move_control = Vector2()
var vel = Vector2()
var moving = false
export (NodePath) var danger_text_path
export (NodePath) var warn_text_path

onready var danger_txt = get_node(danger_text_path)
onready var warn_txt = get_node(warn_text_path)

onready var fov_node = get_node("FOV")

func check_fov():
	if fov_node:
		if danger_txt:
			danger_txt.text="Danger: "+str(fov_node.in_danger_area)
		if warn_txt:
			warn_txt.text="Warn: "+str(fov_node.in_warn_area)

func _physics_process(delta):
	check_fov()
	var pos = get_position()
	var dir = (get_global_mouse_position() - pos).normalized()
	set_rotation(deg2rad(rad2deg(dir.angle())))

	
	# vel = Vector2()
	move_control = Vector2()

	moving = false
	if Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left"):
		move_control.x = -1
		moving = true
	elif Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right"):
		move_control.x = 1
		moving = true
	
	if Input.is_key_pressed(KEY_W) or Input.is_action_pressed("ui_up"):
		move_control.y = -1
		moving = true
	elif  Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down"): 
		move_control.y = 1
		moving = true
	
	vel = (move_control.normalized() * speed)
	
	vel = move_and_slide(vel, Vector2())


