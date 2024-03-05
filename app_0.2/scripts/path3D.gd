extends PathFollow3D

var speed = 0.7
var stop1 = false
var stop2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	if progress_ratio > 0.14 and !stop1 :
#		await get_tree().create_timer(1).timeout
#	if progress_ratio > 0.3 and !stop2 :
#		await get_tree().create_timer(1).timeout
#		stop2 = true
	set_progress((get_progress() + speed *  delta))
