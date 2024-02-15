extends XROrigin3D

@onready var raycast = $XRCamera3D/RayCast3D
var last_target
@onready var animation_player = $AnimationPlayer
@onready var label = $XRCamera3D/Label3D


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.add_to_group("player")
	
func _ready():
	subtitles_trigger()


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

func subtitles_trigger():
	animation_player.play("sous-titres fr")
