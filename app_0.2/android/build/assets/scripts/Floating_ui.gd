extends StaticBody3D
@onready var mesh_instance_3d = $MeshInstance3D
var looked_at : bool = false
@onready var label = $"../Label3D"
@onready var control = $"../SubViewport/Control"
@onready var player = get_tree().get_nodes_in_group("player")[0]

var filled_text = "Bravo !"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if looked_at:
		control.fill = true
	else:
		control.fill = false
	
	# always look in the direction of the player (rotating only on the y axis)
	var target_pos = player.position*Vector3(1,0,1) + self.position*Vector3(0,1,0) 
	if target_pos != self.position:
		look_at(target_pos, Vector3(0,1,0), true)
	

func set_looked_at(status : bool):
	looked_at = status
	if looked_at and control.filled == false : 
		label.change_text( " Se téléporter ")
	else :
		label.change_text( " Téléportation... ")

func _on_progress_filled():
	label.change_text(filled_text)
	var tp_target = self.position*Vector3(1,0,1) + player.position*Vector3.UP
	var tween = get_tree().create_tween()
	tween.tween_property(player, "position", tp_target, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
