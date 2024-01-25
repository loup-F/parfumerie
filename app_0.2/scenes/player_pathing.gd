extends Node3D
var points = [] 
@export var target : Node
#@onready var player = stringt("")$"../dummy"

# Called when the node enters the scene tree for the first time.
func _ready():
	print(target)
	if !target:
		target = $"../dummy"
	for child in get_children():
		points.append(child)
		child.visible = false
	print(points)
	animate_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func animate_player():
	var tween = get_tree().create_tween()
	tween.tween_property(target, "position", points[1].global_position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(2)
	tween.tween_property(target, "position", points[2].global_position, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.play()
