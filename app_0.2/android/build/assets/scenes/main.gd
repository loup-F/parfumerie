extends Node3D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	if $Fps_player :
		player = $Fps_player
	else: 
		player = $Xr_player
	print("root : ", player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
