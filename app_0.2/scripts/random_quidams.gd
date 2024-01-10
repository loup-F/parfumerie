extends Node3D

var quidam = preload("res://scenes/quidam.tscn")
@onready var timer = $Timer
@export var max_delay : float = 4.0
@export var min_delay : float  = 2.0

@onready var spawn1 =  $"SpawnPoints/1"
@onready var spawn2 = $"SpawnPoints/2"
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randf_range(max_delay, min_delay)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	create_quidam()
	timer.wait_time = randf_range(max_delay, min_delay)

func create_quidam():
	var random = quidam.instantiate()
	add_child(random)
	if randi()%2 == 0:
		random.position = spawn1.position + Vector3(randf_range(-3,3), 0, 0)
	else: 
		random.position = spawn2.position + Vector3(randf_range(-3,3), 0, 0)
		random.speed *= -1

