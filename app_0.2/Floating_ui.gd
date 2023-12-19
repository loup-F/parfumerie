extends StaticBody3D
@onready var mesh_instance_3d = $MeshInstance3D
var looked_at : bool = false
@onready var label_3d = $"../Label3D"
@onready var control = $"../SubViewport/Control"
@onready var player = $"../IDontHaveAHeadSet"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if looked_at:
		control.fill_up()
	else:
		control.empty()
	
#	look_at(player.position, Vector3(0,1,0), true)
	rotate(Vector3.UP, self.position.angle_to(player.position))

func set_looked_at(status : bool):
	looked_at = status
	if status: 
		label_3d.change_text( " :) ")
	else :
		label_3d.change_text( " Look at me ! ")
