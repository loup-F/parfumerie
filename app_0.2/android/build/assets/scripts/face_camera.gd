extends Node3D
@onready var player = $"../XROrigin"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player.position, Vector3(0,1,0), true)
