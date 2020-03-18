extends Node2D

export var in_prison: bool
var pairs_in_a_row: int
export var current_field: int = 0
var dice1
var dice2
var pair_thrown: bool
export var money: int
var main: Node2D
var board

tool

	
func _ready():
	print("Player Setup Initialized")
	print(main)
	move(0)
	print("Player Setup Finsished")

func _process(delta):
	#move(current_field)
	print(main)
	
func make_move():
	if in_prison:
		prisonbreak()
	else:
		throw_dice()
	current_field += dice1 + dice2
	if current_field > main.get_board().get_field_amount():
		current_field -= main.get_board().get_field_amount()

func throw_dice():
	dice1 = randi() % 6 + 1
	dice2 = randi() % 6 + 1
	if dice1 == dice2:
		pair_thrown = true
		pairs_in_a_row+= 1
	else:
		pairs_in_a_row = 0
	if pairs_in_a_row > 3:
		in_prison = true

func prisonbreak():
	for i in range(3):
		throw_dice()
		if pair_thrown:
			in_prison = false
			return true
	return false

func move(field_number):
	# sometimes Board and Main are Null
	print("Trying to move")
	print(board)
	print(main)
	self.position = board.get_field(field_number).get_global_position()
	print("Moved lazer")

func set_main(Main):
	main = Main
	board = main.get_board()













