extends VBoxContainer
tool

export var street_name: String = "Streetname"
export var color: String = "Color"
export var prize: int = 0
export var rent: int = 0
var field_position: int
var players_on_field = []
var slots = []

func _ready():
	if not Engine.editor_hint:
		print("{name} Setup Initialized".format({"name":street_name}))
		self.add_to_group("field")
		$MarginContainer/VBoxContainer/Streetname.set_text(street_name)
		$MarginContainer/VBoxContainer/Price.set_text("$" + str(prize))
		for slot in $MarginContainer/GridContainer.get_children():
			slots.append(slot)
		print("{name} Setup Finished".format({"name":street_name}))


func _process(delta):
	update_text()

func set_field_position(position):
	self.field_position = position
	
func update_text():
	# Update Text
	if Engine.editor_hint:
		$MarginContainer/VBoxContainer/Streetname.set_text(street_name)
		$MarginContainer/VBoxContainer/Price.set_text("$" + str(prize))
	
	var current_size = self.get_size()
	$MarginContainer/VBoxContainer/Price.get("custom_fonts/font").set_size(current_size.x/8)
	$MarginContainer/VBoxContainer/Streetname.get("custom_fonts/font").set_size(current_size.x/8)

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