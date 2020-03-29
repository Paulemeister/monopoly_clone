extends Sprite
tool
class_name ColorRect2D

var color: Color = Color(255,0,0)

func _enter_tree():
	print("hello")

func _ready():
	print("hello2")


	
func _init().():
	var gradiant_texture = GradientTexture.new()
	gradiant_texture.gradient = Gradient.new()
	gradiant_texture.gradient.set_offsets(PoolRealArray([0]))
	gradiant_texture.gradient.set_colors(PoolColorArray([self.color]))
	gradiant_texture.set_width(1)
	self.set_texture(gradiant_texture)
	self.set_centered(false)

func set_color(new_color:Color):
	self.color = new_color
	self.texture.gradient.set_colors(PoolColorArray([self.color]))
	return

