extends Control

class_name Field_Baseclass

var field_position: int
var players_on_field = []
var slots = []

func _ready():
	for slot in $GridContainer.get_children():
		slots.append(slot) 

func set_field_position(position):
	self.field_position = position

#func _init(position: int = 0):
	#pass

func pre_dice_action():
	pass

func after_dice_action():
	pass

func player_entered(player):
	print("player entered")
	players_on_field.append(player)
	slots[len(players_on_field)].add_child(player)
	
func player_left(player):
	players_on_field.remove(players_on_field.find(player))
	print("player lest")
	self.remove_child(player)

func get_player_amount_on_field():
	return len(players_on_field)



