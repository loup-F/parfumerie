extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.visible = false
	var player = get_tree().get_first_node_in_group("player")
	print(player)
	player.position = self.position
