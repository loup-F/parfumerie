extends Node3D

@onready var timer = $Timer
@export var max_delay : float = 4.0
@export var min_delay : float  = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randf_range(max_delay, min_delay)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var type = randi_range(1, 3)
	create_quidam(type)
	color_quidam()
	timer.wait_time = randf_range(max_delay, min_delay)

func create_quidam(type):
	match type:
		1: 
			print("mec")
		2:
			print("meuf")
		3: 
			print("feur")

func color_quidam():
	$Quidam.rand_color()
