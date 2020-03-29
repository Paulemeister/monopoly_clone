extends MarginContainer
tool

export var field_size_percentage: float = 0.15
var fields = []
var field_size: Vector2
var field_amount: int
var prison_field: int = 7
export var size_fixed: bool = false
export var fixed_size: Vector2 = Vector2()

func _ready():
	if not Engine.editor_hint:
		print("Board Setup Initialized")
		self.add_to_group("board")
		get_fields()
		print("Board Setup Finished")

func _process(delta):
	arrange_stuff()

func get_field_amount():
	return self.field_amount

func arrange_stuff():
	if size_fixed:
		field_size = fixed_size
	else:
		field_size = get_parent().get_size()
	self.set_size(field_size)
	var actual_size = self.get_size()
	var offset = int(field_size.y*field_size_percentage)
	
	# Set size of Corner Fields
	$"ReferenceRect/Top Left".set_size(Vector2(offset,offset))
	$"ReferenceRect/Top Right".set_size(Vector2(offset,offset))
	$"ReferenceRect/Bottom Left".set_size(Vector2(offset,offset))
	$"ReferenceRect/Bottom Right".set_size(Vector2(offset,offset))
	
	# Set Positions of Corner Fields
	$"ReferenceRect/Top Left".set_position(Vector2(0,0))
	$"ReferenceRect/Top Right".set_position(Vector2(actual_size.x-offset,0))
	$"ReferenceRect/Bottom Left".set_position(Vector2(0,actual_size.y-offset))
	$"ReferenceRect/Bottom Right".set_position(Vector2(actual_size.x-offset,actual_size.y-offset))
	
	# Set Sizes of Other Fields
	$ReferenceRect/Top.set_size(Vector2(actual_size.x-2*offset,offset))
	$ReferenceRect/Bottom.set_size(Vector2(actual_size.x-2*offset,offset))
	$ReferenceRect/Left.set_size(Vector2(actual_size.y-2*offset,offset))
	$ReferenceRect/Right.set_size(Vector2(actual_size.y-2*offset,offset))
	
	# Rotate Fields
	$ReferenceRect/Top.set_rotation_degrees(180)
	$ReferenceRect/Left.set_rotation_degrees(90)
	$ReferenceRect/Right.set_rotation_degrees(270)
	
	# Set Positions of Other Fields
	$ReferenceRect/Top.set_position(Vector2(actual_size.x-offset,offset))
	$ReferenceRect/Bottom.set_position(Vector2(offset,actual_size.y-offset))
	$ReferenceRect/Left.set_position(Vector2(offset,offset))
	$ReferenceRect/Right.set_position(Vector2(actual_size.x-offset,actual_size.y-offset))
	
func get_fields():
	field_amount = 0
	fields = []
	for container in $ReferenceRect.get_children():
		var temp = []
		var temp_lenght 
		for field in container.get_children():
			temp.append(field)
		temp_lenght = len(temp)
		for i in range(temp_lenght):
			var field = temp[temp_lenght-i-1]
			fields.append(field)
			field.set_field_position(field_amount)
			field_amount += 1
	print("Got Fields")

func get_field(number):
	return fields[number]










