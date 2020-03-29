extends MarginContainer


export var in_prison: bool
var pairs_in_a_row: int
export var current_field: int = 0
var Current_Field
var Last_Field
var dice1
var dice2
var pair_thrown: bool
export var money: int
var main: Node2D
var board
var type: String = "player"
var size_percentage: float = 0.05

export var colors: PoolColorArray = PoolColorArray()


func _ready():
	print("Player Setup Initialized")
	self.add_to_group("player")
	main = get_tree().get_nodes_in_group("main")[0]
	board = main.get_board()
	update_current_field()
	print("Player Setup Finsished")

func _process(delta):
	arrange_stuff()
	pass
	
func make_move():
	if in_prison:
		if not prisonbreak():
			return
	throw_dice()
	current_field += dice1 + dice2
	if current_field > board.get_field_amount()-1:
		current_field -= board.get_field_amount()-1
	update_current_field()
	move(current_field)

func throw_dice():
	dice1 = randi() % 6 + 1
	dice2 = randi() % 6 + 1
	if dice1 == dice2:
		pair_thrown = true
		pairs_in_a_row+= 1
		if pairs_in_a_row > 3:
			in_prison = true
			current_field = board.get_prison_field()
	else:
		pair_thrown = false
		pairs_in_a_row = 0
	

func prisonbreak():
	for i in range(3):
		throw_dice()
		if pair_thrown:
			in_prison = false
			return true
	return false

func move(field_number):
	#print("Trying to move")
	print()
	print(board)
	print(Last_Field)
	print(current_field)
	print(Current_Field)
	if Last_Field != null:
		Last_Field.player_left(self)
	Current_Field.player_entered(self)
	#arrange_stuff()
	#print("Moved Player")

func set_main(Main):
	main = Main
	board = main.get_board()

func set_color(variant):
	$Label.set_text(str(variant+1))
	while variant > len(colors)-1:
		variant -= len(colors)
	$ColorRect.color = colors[variant]

func arrange_stuff():
	var size = min(board.get_size().x,board.get_size().y)*size_percentage
	self.set_size(Vector2(size,size))
	var offset = Current_Field.get_player_amount_on_field()*size
	self.set_rotation_degrees(Current_Field.get_parent().get_rotation_degrees())
	self.set_position(Current_Field.get_global_position())#+ Vector2(offset,0))

func update_current_field():
	Last_Field = Current_Field
	Current_Field = board.get_field(current_field)
	print("updated field")	











