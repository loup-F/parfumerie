extends CharacterBody3D

@onready var raycast = $Camera3D/RayCast3D
var previous # previous raycast target


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_sensitivity = 0.002

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
signal fade_done

func _enter_tree():
	self.add_to_group("player")

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if event.is_action_pressed("click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready():
	if has_node("/root/main/Xr_player"):
		self.remove_from_group("player")
		self.queue_free()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		fade_in()
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	
	# =================================================
	# RAYCAST (partie commune avec le controller VR)
	# =================================================
	
	# récupère les infos de collision du raycast 
	var target = raycast.get_collider()

	#target = current collision, previous commence null
	if target and previous == null:
		target.looked_at = true # trigger une seule foi
		previous = target
	# si on ne détecte rien mais qu'on détectait une target avant :
	elif previous !=null and target == null:
		previous.looked_at = false #trigger une seule foi
		previous = target

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 1.0, 0.0, 1.0)
	await tween.finished
	emit_signal("fade_done")
#
func fade_to_black():
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 0.0, 1.0, 1.0)
	await tween.finished
	emit_signal("fade_done")
#
func set_fade(p_value : float):
	if p_value == 0.0:
		%Fade.visible = false
	else:
		var material : ShaderMaterial = %Fade.get_surface_override_material(0)
		if material:
			material.set_shader_parameter("alpha", p_value)
			print(p_value)
		%Fade.visible = true
