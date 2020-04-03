extends Spatial
tool
class_name FieldBaseClass3D

export var thickness: int = 20

func _ready():
	pass

func pre_dice():
	pass

func past_dice():
	pass

func add_outline():
	for child in self.get_children():
		var OutlineMesh = child.get_mesh().create_outline(2)
		var Outline = MeshInstance.new()
		Outline.set_mesh(OutlineMesh)
		Outline.set_material_override(SpatialMaterial.new())
		Outline.get_material_override().set_roughness(0.3)
		Outline.get_material_override().set_albedo(Color(0.1,0.1,0.1))
		child.add_child(Outline)
		Outline.set_owner(self.get_owner())
		Outline.set_name("Outline")
