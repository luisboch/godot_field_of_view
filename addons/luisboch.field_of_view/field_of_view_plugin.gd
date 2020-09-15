tool
extends EditorPlugin

var wind_singleton

func _enter_tree():
	add_custom_type("FieldOfView", "Node2D",\
		load("res://addons/luisboch.field_of_view/field_of_view.gd"),\
		load("res://addons/luisboch.field_of_view/node_icon.png"))
func _exit_tree():
	remove_custom_type("FieldOfView")
