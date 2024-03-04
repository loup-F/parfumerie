extends XROrigin3D

@onready var raycast = $XRCamera3D/RayCast3D
var previous
@onready var animation_player = $AnimationPlayer
@onready var label = $XRCamera3D/XR_Label
@onready var reticule = $XRCamera3D/reticule
@export var in_menu = true 
signal faded_out
signal faded_in
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.add_to_group("player")
	
func _ready():
	fade_in()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	if in_menu:
#		cast()
	if reticule.visible and in_menu == false:
		reticule.visible = false
	# =================================================
	# RAYCAST (partie commune avec le controller VR)
	# =================================================
#func cast():
	var target = raycast.get_collider()
	if target and previous == null:
		target.looked_at = true
		previous = target
	elif previous !=null and target == null:
		previous.looked_at = false
		previous = target

func subtitles_trigger():
	animation_player.play("sous-titres fr")
	
func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 1.0, 0.0, 1.0)
	emit_signal("faded_in")

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 0.0, 1.0, 1.0)
	emit_signal("faded_out")
	
func set_fade(p_value : float):
	if p_value == 0.0:
		$Fade.visible = false
	else:
		var material : ShaderMaterial = $Fade.get_surface_override_material(0)
		if material:
			material.set_shader_parameter("alpha", p_value)
		$Fade.visible = true
