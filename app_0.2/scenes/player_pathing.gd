extends Node3D
var points = [] 
@export var player : Node
@onready var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	if !player:
		var xrplayer = get_node("../XROrigin") 
		if xrplayer:
			player = xrplayer
	for child in get_children():
		points.append(child)
		child.visible = false
	player.position = points[0].position
	animate_player()


func animate_player():
	wait(0.5)
	move_to(points[1])
	wait(0.5)
	rotate_and_move_to(points[2])
#	for point in points:
#		wait_for(0.5)
#		move_to(point)

func rotate_and_move_to(target):
	tween.set_parallel(true)
	tween.tween_property(player, "rotation", target.rotation, 2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(player, "position", target.position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

func move_to(target):
	tween.set_parallel(false)
	tween.tween_property(player, "position", target.position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

func wait(time):
	tween.tween_interval(time)
