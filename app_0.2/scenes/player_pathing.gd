extends Node3D
var points = [] 
@export var target : Node
#@onready var player = stringt("")$"../dummy"

# Called when the node enters the scene tree for the first time.
func _ready():
	if !target:
		target = $"../dummy"
	for child in get_children():
		points.append(child)
		child.visible = false
	target.position = points[0].position
	animate_player()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func animate_player():
	var tween = get_tree().create_tween()
	tween.tween_interval(0.5)
#	for point in points:
#		tween.tween_interval(0.5)
#		tween.tween_property(target, "position", point.position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
#		tween.play()
#	tween.set_parallel(true)
	tween.tween_property(target, "rotation", points[1].rotation, 2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(0.5)
	tween.tween_property(target, "position", points[1].position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
#	tween.set_parallel(false)
	tween.tween_interval(1)
	tween.tween_property(target, "position", points[2].position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.play()

