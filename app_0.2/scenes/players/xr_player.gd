extends XROrigin3D

@onready var raycast = $XRCamera3D/RayCast3D
var previous
@onready var animation_player = $AnimationPlayer
@onready var label = $XRCamera3D/XR_Label
@onready var reticule = $XRCamera3D/reticule
var in_menu = true
@onready var object_to_fade = %FadeBlack 
signal fade_done

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.add_to_group("player")
	
func _ready():
	fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if in_menu:
		cast()
	elif %reticule.visible == true:
		%reticule.visible = false
	# =================================================
	# RAYCAST (partie commune avec le controller VR)
	# =================================================
func cast():
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
	tween.tween_method(set_fade, 1.0, 0.0, 1.0).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	await tween.finished
	emit_signal("fade_done")
	
func fade_to_black():
	set_fade_color_black()
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await tween.finished
	emit_signal("fade_done")

func set_fade(p_value : float):
	if p_value == 0.0:
		object_to_fade.visible = false
	else:
		var material : ShaderMaterial = object_to_fade.get_surface_override_material(0)
		if material:
			material.set_shader_parameter("alpha", p_value)
		object_to_fade.visible = true

func set_fade_color_black():
	if object_to_fade != %FadeBlack:
		object_to_fade = %FadeBlack

func set_fade_color_white():
	if object_to_fade != %FadeWhite:
		object_to_fade = %FadeWhite
