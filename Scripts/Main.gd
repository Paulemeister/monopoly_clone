extends Node2D
tool

export var player_amount: int = 1
var players = []
var Board
var timer
var game_paused: bool = true
var game_running: bool = false
signal game_paused
signal game_resumed
signal game_started
	
func _ready():
	if not Engine.editor_hint:
		print("Game Setup Initialized")
		self.add_to_group("main")
		print("Added Main to Group")
		Board = get_tree().get_nodes_in_group("board")[0]
		print("Got Board")
		
		for i in range(player_amount):
			var player_instance = preload("res://Scenes/Player.tscn").instance()
			players.append(player_instance)
			self.add_child(player_instance)
			player_instance.set_color(i)
			player_instance.set_main(self)
		print("Got Players")
		self.connect("game_started",self,"gamelogic")
		self.emit_signal("game_started")
		print("Game Setup Finished")

func  _process(delta):
	arrange_stuff()

func _physics_process(delta):
	if not Engine.editor_hint:
		if Input.is_action_just_pressed("ui_accept"):
			print("ui_accept just pressed")
			if game_paused:
				self.emit_signal("game_resumed")
				game_paused = false
			else:
				self.emit_signal("game_paused")
				game_paused = true
			print(game_paused)

func arrange_stuff():
	var screensize: Vector2
	if Engine.editor_hint:
		screensize = Vector2(1024,600)
	else:
		screensize = get_viewport().size
	
	var smaller_component = min(screensize.x,screensize.y)
	$ReferenceRect.set_size(Vector2(smaller_component,smaller_component))
	$MarginContainer.set_size(screensize)
	$ReferenceRect.set_position(Vector2((screensize.x-smaller_component)/2,0))

func gamelogic():
	print("Starting Gamelogic")
	game_running = true
	while game_running:
		for player in players:
			if game_paused:
				yield(self,"game_resumed")
			player.make_move()
			print("Made a Move")
			yield(get_tree().create_timer(1.0), "timeout")

func get_board():
	return Board