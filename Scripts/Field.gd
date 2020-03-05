extends VBoxContainer
tool

export var street_name: String = "Streetname"
export var color: String = "Color"
export var prize: int = 0
export var rent: int = 0

func _ready():
	$MarginContainer/VBoxContainer/Streetname.set_text(street_name)
	$MarginContainer/VBoxContainer/Price.set_text("$" + str(prize))


func _process(delta):
	update_shit()

func update_shit():
	# Update Text
	if Engine.editor_hint:
		$MarginContainer/VBoxContainer/Streetname.set_text(street_name)
		$MarginContainer/VBoxContainer/Price.set_text("$" + str(prize))
	
	var current_size = self.get_size()
	$MarginContainer/VBoxContainer/Price.get("custom_fonts/font").set_size(current_size.x/8)
	$MarginContainer/VBoxContainer/Streetname.get("custom_fonts/font").set_size(current_size.x/8)