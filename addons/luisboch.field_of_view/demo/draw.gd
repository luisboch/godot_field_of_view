@tool
extends Node2D

@export var color = Color.BLUE: 
	set (value):
		color = value
		# Forces new draw
		super.queue_redraw()
		
@export var size = Vector2(48.0, 48.0):
	set(value):
		size = value
		# Forces new draw
		super.queue_redraw()
	
func _draw():
	# Draw filled rectangle, using local position (based on parent is 0.0, 0.0)
	# centered
	draw_rect(Rect2(get_position() - (size * 0.5), size), color, true)
	

