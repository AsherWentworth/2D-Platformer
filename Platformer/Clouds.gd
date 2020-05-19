extends Sprite

func _ready():
	material.set_shader_param("direction", Vector2(1.0,0.0))
	material.set_shader_param("speed_scale",0.02)
