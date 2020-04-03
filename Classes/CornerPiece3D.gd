extends "res://Classes/FieldBaseClass3D.gd"
tool
class_name CornerPiece3D
export var color = Color(1,1,1)

func _ready():
	var parent_has_owner = get_parent().get_owner() != null
	if parent_has_owner:
		self.set_owner(get_parent().get_owner())
	else:
		self.set_owner(get_parent())
	
	var NewNode = MeshInstance.new()
	self.add_child(NewNode)
	NewNode.set_owner(self.get_owner())
	NewNode.set_name("Square")
	
	var NewMesh = CubeMesh.new()
	NewMesh.set_size(Vector3(194,self.thickness,194))
	NewMesh.set_material(SpatialMaterial.new())
	NewMesh.get_material().set_roughness(0.3)
	NewMesh.get_material().set_albedo(self.color)
	$Square.set_mesh(NewMesh)
	$Square.set_translation(Vector3(-2,0,2))
	
	#self.add_outline()
	
	print("created a CornerPiece")
	#self.set_scale(Vector3(0.125,0.125,0.125))
