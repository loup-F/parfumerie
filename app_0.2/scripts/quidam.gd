extends StaticBody3D

var direction = Vector3(0,0,1)
@export var speed = 3

@onready var mesh = $MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	rand_color()
	speed = randf_range(2.8, 3.8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var motion = direction * delta * speed
	move_and_collide(motion)

func rand_color():
	var random_rgb = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
	mesh.get_surface_override_material(0).albedo_color = random_rgb
