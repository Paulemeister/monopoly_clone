extends "res://Classes/FieldBaseClass3D.gd"
tool
class_name Street3D

export var street_name: String = "Streetname"
export var color: Color = Color(255,0,0)
export var prize: int = 0
export var rent: int = 0

var field_position: int
var players_on_field = []
var slots = []


func _ready():
	var parent_has_owner = get_parent().get_owner() != null
	if parent_has_owner:
		self.set_owner(get_parent().get_owner())
	else:
		self.set_owner(get_parent())
	var NewNode = MeshInstance.new()
	self.add_child(NewNode)
	NewNode.set_name("Top")
	$Top.set_owner(self.get_owner())
	
	NewNode = MeshInstance.new()
	self.add_child(NewNode)
	NewNode.set_name("Bottom")
	$Bottom.set_owner(self.get_owner())


	var NewMesh = CubeMesh.new()
	NewMesh.set_size(Vector3(151,self.thickness,123))
	$Bottom.set_mesh(NewMesh)
	$Bottom.set_translation(Vector3(-23.5,0,0))
	
	NewMesh = CubeMesh.new()
	NewMesh.set_size(Vector3(47,self.thickness,123))
	NewMesh.set_material(SpatialMaterial.new())
	NewMesh.get_material().set_roughness(0.6)
	NewMesh.get_material().set_albedo(self.color)
	$Top.set_mesh(NewMesh)
	$Top.set_translation(Vector3(75.5,0,0))
	
	#self.set_scale(Vector3(0.125,0.125,0.125))
	get_tree().connect("node_configuration_warning_changed",self,"_on_node_configuration_warning_changed")
	print("created a Street")
	
func _on_node_configuration_warning_changed(node: Node):
	print("node changed")