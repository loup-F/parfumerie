extends Label3D
@onready var player = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# always look in the direction of the player (rotating only on the y axis)
	var target_pos = player.position * Vector3(1,0,1) + self.position*Vector3(0,1,0) 
	look_at(target_pos, Vector3(0,1,0), true)
	pass

func change_text(newtext : String):
	text = newtext

