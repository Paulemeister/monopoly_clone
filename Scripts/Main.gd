extends Node2D

func  _process(delta):
	var screensize = get_viewport().size
	$MarginContainer.set_size(screensize)
	$Board.set_position(Vector2(screensize.y/4,0))