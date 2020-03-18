extends MarginContainer
tool

export var wanted_size: int = 600
export var field_size_percentage: float = 0.15
var fields = []
export var fix_square: bool = true
var field_size: int
var field_amount: int
func _ready():
	print("Board Setup Initialized")
	get_fields()
	print("Board Setup Finished")

func _process(delta):
	arrange_stuff()

func get_field_amount():
	return self.field_amount

func arrange_stuff():
	var actual_size = self.get_size()
	
	if Engine.editor_hint:
		if fix_square:
			field_size = wanted_size
			self.set_size(Vector2(wanted_size,wanted_size))
		else:
			field_size = min(actual_size.x, actual_size.y)
	else:
		field_size = get_parent().get_size().y
		self.set_size(Vector2(field_size,field_size))
		
	var offset = int(field_size*field_size_percentage)
	
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
	for container in $ReferenceRect.get_children():
		var temp = []
		var temp_lenght 
		for field in container.get_children():
			temp.append(field)
		temp_lenght = len(temp)
		for i in range(temp_lenght):
			fields.append(temp[temp_lenght-i-1])
			field_amount += 1
	print("Got Fields")
			
func get_field(number):
	return fields[number]










