extends "res://Classes/FieldBaseClass3D.gd"
tool
class_name Street3D

export var street_name: String = "Streetname"
export var color: Color = Color(1,1,1)
export var price: int = 0
export var rent: int = 0

var colors: = {
	"Brown":Color("955436"),
	"Light Blue":Color("aae0fa"),
	"Pink":Color("d93a96"),
	"Orange":Color("f7941d"),
	"Red":Color("ed1b24"),
	"Yellow":Color("fef200"),
	"Green":Color("1fb25a"),
	"Blue":Color("0072bb")
}
var field_position: int
var players_on_field = []
var slots = []

func _init(color: String = "Color",street_name: String="Streetname",price: int= 0):
	self.color = colors.get(color,Color(1,1,1))
	self.add_to_group(color)
	self.street_name = street_name
	self.price = price
	
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
	NewMesh.set_size(Vector3(151,self.thickness,119))
	NewMesh.set_material(SpatialMaterial.new())
	NewMesh.get_material().set_roughness(0.3)
	NewMesh.get_material().set_albedo(Color(1,1,1))
	$Bottom.set_mesh(NewMesh)
	$Bottom.set_translation(Vector3(-23.5,0,0))
	
	NewMesh = CubeMesh.new()
	NewMesh.set_size(Vector3(47,self.thickness,119))
	NewMesh.set_material(SpatialMaterial.new())
	NewMesh.get_material().set_roughness(0.3)
	NewMesh.get_material().set_albedo(self.color)
	$Top.set_mesh(NewMesh)
	$Top.set_translation(Vector3(75.5,0,0))
	
	#self.add_outline()
	
	#self.set_scale(Vector3(0.125,0.125,0.125))
	get_tree().connect("node_configuration_warning_changed",self,"_on_node_configuration_warning_changed")
	print("Created "+self.street_name)
	
func _on_node_configuration_warning_changed(node: Node):
	print("node changed")