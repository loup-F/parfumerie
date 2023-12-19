extends XROrigin3D
@onready var ray_cast_3d = $XRCamera3D/RayCast3D
@onready var label_3d_2 = $"../Label3D2"
@onready var label_3d = $"../Label3D"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_3d.get_collider():
		var coll = ray_cast_3d.get_collider()
		coll.changeTexture()
	else: 
		label_3d.change_text("nope")
		label_3d_2.change_text("nope")
