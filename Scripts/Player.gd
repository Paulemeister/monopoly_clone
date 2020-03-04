extends Node2D

const field_lenght = 30
export var in_prison: bool
var pairs_in_a_row: int
export var current_field: int
var dice1
var dice2
var pair_thrown: bool
export var money: int

func _ready():
	pass 

func make_move():
	if in_prison:
		prisonbreak()
	else:
		throw_dice()
	current_field += dice1 + dice2
	if current_field > field_lenght:
		current_field -= field_lenght

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
