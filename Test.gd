extends Node2D

func _ready():
	var node = ColorRect2D.new()
	node.set_color(Color(255,255,0))
	add_child(node)
	node.set_scale(Vector2(100,100))
	