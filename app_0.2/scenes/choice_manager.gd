extends Node3D

@onready var mat1 = $Choix1/FloatingOpt1/MeshInstance3D.get_active_material(0)
@onready var mat2 = $Choix1/FloatingOpt2/MeshInstance3D.get_active_material(0)
@onready var mat3 = $Choix2/FloatingOpt3/MeshInstance3D.get_active_material(0)
@onready var mat4 = $Choix2/FloatingOpt4/MeshInstance3D.get_active_material(0)

signal load_main

func _ready():
	var level_manager = get_parent().get_parent()
	if level_manager.name == "LevelManager":
		load_main.connect(level_manager.load_main)

func on_picked():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.finished.connect(second_choice)
	tween.tween_property(mat1, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat2, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

func second_choice():
	$Choix1/FloatingOpt1.set_collision_layer_value(3, false)
	$Choix1/FloatingOpt2.set_collision_layer_value(3, false)
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(mat3, "albedo_color:a", 1, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat4, "albedo_color:a", 1, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	$Choix2/FloatingOpt3.set_collision_layer_value(3, true)
	$Choix2/FloatingOpt4.set_collision_layer_value(3, true)

func on_picked_2(): 
	var tween = get_tree().create_tween().set_parallel(true)
	tween.finished.connect(load_level)
	tween.tween_property(mat3, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat4, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

func load_level():
	emit_signal("load_main")
