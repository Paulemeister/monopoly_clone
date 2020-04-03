extends Spatial
tool
class_name Board3D

export var speed: float = 2
export var height: float= 200
export var wobble: bool = true

var length = 1301
var fields = []
var time_passed: float = 0

signal wobble_stopped

func _ready():
	#Fix Children Duplicating
	for child in self.get_children():
		child.free()
	
	if get_parent().get_owner() != null:
		self.set_owner(get_parent().get_owner())
	else:
		self.set_owner(get_parent())
	
	self.connect("wobble_stopped",self,"reset_board")
	
	create_from_file("res://Boards/Board1.txt")
	
func _physics_process(delta):
	if not Engine.editor_hint:
		if Input.is_action_just_pressed("ui_accept"):
			print("ui_accept just pressed")
			wobble = !wobble
			if !wobble:
				emit_signal("wobble_stopped")
	if wobble:
		wobble(delta)

func _fixed_process(delta):
	if wobble:
		wobble(delta)

func reset_board():
	for field in fields:
		var current_position = field.get_translation()
		field.set_translation(Vector3(current_position.x,0,current_position.z))
	
func wobble(delta):
	time_passed += delta
	#Checking for len(fields) returns 0 half of the time
	var offset:float = 2*PI/40
	for i in range(40):
		var current_position = fields[i].get_translation()
		var new_y = height*sin((time_passed+i*offset)*speed) + height
		fields[i].set_translation(Vector3(current_position.x,new_y,current_position.z))

func calc_field_pos(i,j):
		if i== 0:
			return self.length/2.0-158.5-j*123
		elif i == 1:
			return self.length/-2.0
		elif i== 2:
			return self.length/-2.0+158.5+j*123
		elif i == 3:
			return self.length/2.0

func create_from_file(filename):
	
	var file = File.new()
	
	if file.open(filename, File.READ) != 0:
		print("Error opening file")
		return
	
	var text = file.get_as_text()
	var lines = text.split("\n")
	if len(lines)!= 40:
		print("File doesn't match required format. File is {abc} lines long!".format({"abc":len(lines)}))
		return
	var corner_param = [2.0,-2.0,-2.0,2.0]
	for i in range(4):
		
		#set offset for left variables and make sure it loops back around
		var l = i +1
		if l==4:
			l=0
		
		#Check which CornerPiece
		var parameters = lines[10*i].split(";")
		
		if parameters[0]== "":
			pass
		else:
			var NewField = CornerPiece3D.new()
			NewField.set_rotation_degrees(Vector3(0,-90*i,0))
			NewField.set_translation(Vector3(length/corner_param[l],0,length/corner_param[i]))
			self.add_child(NewField)
			NewField.set_owner(self.get_owner())
			self.fields.append(NewField)
		
		for j in range(9):
			parameters = lines[10*i+j+1].split(";")
			var NewField
			if parameters[0]=="Street":
				NewField = Street3D.new(parameters[1],parameters[2],int(parameters[3]))
			else:
				NewField = Street3D.new()
			NewField.set_rotation_degrees(Vector3(0,-90*i,0))
			NewField.set_translation(Vector3(calc_field_pos(l,j),0,calc_field_pos(i,j)))
			self.add_child(NewField)
			NewField.set_owner(self.get_owner())
			self.fields.append(NewField)
	self.set_scale(Vector3(0.125,0.125,0.125))

func old_init():
	for child in self.get_children():
		child.free()
	var parent_has_owner = get_parent().get_owner() != null
	if parent_has_owner:
		self.set_owner(get_parent().get_owner())
	else:
		self.set_owner(get_parent())
	
	self.connect("wobble_stopped",self,"reset_board")
	
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