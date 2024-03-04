extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	var xrplayer = get_node("../XROrigin")
	var fpsplayer = get_node("../Fps_player") 
	if xrplayer:
		xrplayer.position = self.position
	elif fpsplayer:
		fpsplayer.position = self.position
