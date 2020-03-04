extends Node2D

export var size = 600
export var field_height = 1/12
var fields
func _ready():
	arrange_gui()
	pass

func _process(delta):
	pass

func arrange_gui():
	size = get_viewport().size.y
	$ColorRect.set_size(Vector2(size,size))