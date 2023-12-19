extends Label3D
@onready var camera_3d = $"../IDontHaveAHeadSet/Camera3D"
@onready var player = $"../IDontHaveAHeadSet"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(player.position, Vector3(0,1,0), true)

func change_text(newtext : String):
	if text != "Bravo !":
		text = newtext
	
func _on_progress_filled():
	text = "Bravo !"
