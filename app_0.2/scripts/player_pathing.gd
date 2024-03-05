extends Node3D
var points = [] 
@export var player : Node
@onready var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
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
	move_to(points[1])
	wait(0.5)
	rotate_and_move_to(points[2])
	wait(0.5)
	rotate_and_move_to(points[3])
	wait(0.5)
	rotate_and_move_to(points[4])
#	for point in points:
#		wait_for(0.5)
#		move_to(point)

func rotate_and_move_to(target):
	tween.set_parallel(true)
	tween.tween_property(player, "rotation", target.rotation, 2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(player, "position", target.position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)

func move_to(target):
	tween.set_parallel(false)
	tween.tween_property(player, "position", target.position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

func wait(time):
	tween.tween_interval(time)
