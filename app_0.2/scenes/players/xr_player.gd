extends XROrigin3D

@onready var raycast = $XRCamera3D/RayCast3D
var previous
@onready var animation_player = $AnimationPlayer
@onready var label = $XRCamera3D/Label3D


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
	if target and previous == null:
		target.looked_at = true
		previous = target
	elif previous !=null and target == null:
		previous.looked_at = false
		previous = target

func subtitles_trigger():
	animation_player.play("sous-titres fr")
