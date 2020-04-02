extends Spatial
tool
class_name Board3D

export var speed: float = 2
export var height: float= 20
export var wabble: bool = false

var length = 1301
var fields = []
var time_passed: float = 0

func _enter_tree():
	for child in self.get_children():
		child.free()
	var parent_has_owner = get_parent().get_owner() != null
	if parent_has_owner:
		self.set_owner(get_parent().get_owner())
	else:
		self.set_owner(get_parent())
	
	#Bottom
	var NewField = CornerPiece3D.new()
	NewField.set_translation(Vector3(length/2,0,length/-2))
	self.add_child(NewField)
	NewField.set_owner(self.get_owner())
	fields.append(NewField)
	for j in range(9):
		NewField = Street3D.new()
		NewField.set_rotation_degrees(Vector3(0,-90,0))
		NewField.set_translation(Vector3(length/2-160.5-j*123,0,length/-2))
		self.add_child(NewField)
		NewField.set_owner(self.get_owner())
		fields.append(NewField)
	
	#Left
	NewField = CornerPiece3D.new()
	NewField.set_translation(Vector3(length/-2,0,length/-2))
	self.add_child(NewField)
	NewField.set_owner(self.get_owner())
	fields.append(NewField)
	for j in range(9):
		NewField = Street3D.new()
		NewField.set_rotation_degrees(Vector3(0,0,0))
		NewField.set_translation(Vector3(length/-2,0,length/-2+160.5+j*123))
		self.add_child(NewField)
		NewField.set_owner(self.get_owner())
		fields.append(NewField)
	
	#Top
	NewField = CornerPiece3D.new()
	NewField.set_translation(Vector3(length/-2,0,length/2))
	self.add_child(NewField)
	NewField.set_owner(self.get_owner())
	fields.append(NewField)
	for j in range(9):
		NewField = Street3D.new()
		NewField.set_rotation_degrees(Vector3(0,90,0))
		NewField.set_translation(Vector3(length/-2+160.5+j*123,0,length/2))
		self.add_child(NewField)
		NewField.set_owner(self.get_owner())
		fields.append(NewField)
	
	#Right
	NewField = CornerPiece3D.new()
	NewField.set_translation(Vector3(length/2,0,length/2))
	self.add_child(NewField)
	NewField.set_owner(self.get_owner())
	fields.append(NewField)
	for j in range(9):
		NewField = Street3D.new()
		NewField.set_rotation_degrees(Vector3(0,-180,0))
		NewField.set_translation(Vector3(length/2,0,length/2-160.5-j*123))
		self.add_child(NewField)
		NewField.set_owner(self.get_owner())
		fields.append(NewField)
	
	self.set_scale(Vector3(0.125,0.125,0.125))

func _ready():
	fields = []
	for field in self.get_children():
		fields.append(field)
	
func _physics_process(delta):
	if not Engine.editor_hint:
		if Input.is_action_just_pressed("ui_accept"):
			print("ui_accept just pressed")
			wabble = !wabble
			if !wabble:
				for field in fields:
					var current_position = field.get_translation()
					field.set_translation(Vector3(current_position.x,0,current_position.z))
	if wabble:
		wabble(delta)

func _fixed_process(delta):
	if wabble:
		wabble(delta)
	
func wabble(delta):
	time_passed += delta
	#Checking for len(fields) returns 0 half of the time
	var offset:float = 2*PI/40
	for i in range(40):
		var current_position = fields[i].get_translation()
		var new_y = height*sin((time_passed+i*offset)*speed) + height
		fields[i].set_translation(Vector3(current_position.x,new_y,current_position.z))