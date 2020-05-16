tool
extends Node2D

export var color = Color.blue setget _set_color
export var size = Vector2(48.0, 48.0) setget _set_size


func _set_color(n_color):
	# update local var
	color = n_color
	
	# Forces new draw
	update()

func _set_size(n_size):
	# update local var
	size = n_size
	
	# Forces new draw
	update()
	
func _draw():
	# Draw filled rectangle, using local position (based on parent is 0.0, 0.0)
	# centered
	draw_rect(Rect2(get_position() - (size * 0.5), size), color, true)
	

