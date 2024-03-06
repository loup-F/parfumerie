extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.visible = false
	var player = get_tree().get_first_node_in_group("player")
	if player.name == "XROrigin":
		self.position.y = 0.9
	player.position = self.position
	player.rotation = self.rotation
	print("player : ", player, " player rotation : ", player.rotation, " self : ", self.rotation)
