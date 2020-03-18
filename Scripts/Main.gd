extends Node2D
tool
export var player_amount: int = 1
var players = []
var Board

func _enter_tree():
	print("Main Entered Tree")
	Board = $ReferenceRect/Board
	print("Got Board")
	
func _ready():
	print("Game Setup Initialized")
	for i in range(player_amount):
		var player_instance = preload("res://Scenes/Player.tscn").instance()
		player_instance.set_main(self)
		players.append(player_instance)
		self.add_child(player_instance)
	print("Got Players")
	print("Game Setup Finished")

func  _process(delta):
	arrange_stuff()


func arrange_stuff():
	var screensize: Vector2
	if Engine.editor_hint:
		screensize = Vector2(1024,600)
	else:
		screensize = get_viewport().size
	$ReferenceRect/MarginContainer.set_size(screensize)
	$ReferenceRect.set_size(screensize)
	$ReferenceRect/Board.set_position(Vector2((screensize.x-$ReferenceRect/Board.get_size().x)/2,0))

func game_logic():
	pass

func get_board():
	print(Board)
	return Board