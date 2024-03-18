extends Node3D
var points = [] 
@export var player : Node
@onready var tween = get_tree().create_tween()
var tween_length = 2.5
signal path_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	var manager = get_parent().get_parent()
	path_finished.connect(manager.load_ending)
	if !player:
		player = get_tree().get_first_node_in_group("player")
	if player.name == "XROrigin":
		for child in get_children():
			child.position.y = 0.9
	for child in get_children():
		points.append(child)
		child.visible = false
	
	animate_player()


func animate_player():
	wait(1)
	rotate_and_move_to(points[1])
	wait(1.5)
	rotate_and_move_to(points[2])
#	wait(1.5)
#	rotate_and_move_to(points[3])
#	wait(1.5)
#	rotate_and_move_to(points[4])
#	wait(1.5)
#	rotate_and_move_to(points[5])
#	for point in points:
#		if point != points[0]:
#			wait(1.5)
#			rotate_and_move_to(point)
	await tween.finished
	emit_signal("path_finished")

func rotate_and_move_to(target):
	tween.set_parallel(true)
	tween.tween_property(player, "rotation", target.rotation, tween_length).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)	
	tween.tween_property(player, "position", target.position, tween_length).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)
	tween.tween_interval(1.5)

func move_to(target):
	tween.set_parallel(false)
	tween.tween_property(player, "position", target.position, tween_length).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func wait(time):
	tween.tween_interval(time)
