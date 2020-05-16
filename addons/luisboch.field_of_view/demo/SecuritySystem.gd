extends Node2D

export (NodePath) var danger_text_path
export (NodePath) var warn_text_path

onready var danger_txt = get_node(danger_text_path)
onready var warn_txt = get_node(warn_text_path)

var danger_nodes;
var warn_nodes;


func _process(delta):
	danger_nodes = []
	warn_nodes = []
	for c in get_children():
		danger_nodes += c.get_danger()
		warn_nodes += c.get_warn()
	check_fov()



func check_fov():
	if danger_txt:
		danger_txt.text="Danger: "+str(danger_nodes)
	if warn_txt:
		warn_txt.text="Warn: "+str(warn_nodes)
