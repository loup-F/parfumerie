extends XROrigin3D

@onready var raycast = $XRCamera3D/RayCast3D
var last_target
@onready var label = $"../Label3D"

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.add_to_group("player")
	
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# =================================================
	# RAYCAST (partie commune avec le controller VR)
	# =================================================
	var target = raycast.get_collider()
	if target and target.is_in_group("UI_target"):
		target.set_looked_at(true)
		last_target = target
	else:
		if last_target !=null:
			last_target.set_looked_at(false)
