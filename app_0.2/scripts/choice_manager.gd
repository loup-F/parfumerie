extends Node3D

@onready var mat1 = $FloatingOpt1/MeshInstance3D.get_active_material(0)
@onready var mat2 = $FloatingOpt2/MeshInstance3D.get_active_material(0)
@onready var mat3 = $FloatingOpt3/MeshInstance3D.get_active_material(0)
@onready var prompt = $Label3D


#signal choice_done
var level_manager = null

func _ready():
	var manager = get_parent().get_parent()
	if manager.name == "LevelManager":
		level_manager = manager
	prompt.text = "choisissez un language"

func on_picked():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.finished.connect(level_manager.load_dest)
	tween.tween_property(mat1, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat2, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat3, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

#func second_choice():
#	prompt.text = "Voulez-vous des sous-titres ?"
#	$Choix1/FloatingOpt1.set_collision_layer_value(3, false)
#	$Choix1/FloatingOpt2.set_collision_layer_value(3, false)
#	var tween = get_tree().create_tween().set_parallel(true)
#	tween.tween_property(mat3, "albedo_color:a", 1, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
#	tween.tween_property(mat4, "albedo_color:a", 1, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
#	$Choix2/FloatingOpt3.set_collision_layer_value(3, true)
#	$Choix2/FloatingOpt4.set_collision_layer_value(3, true)

func on_picked_2(): 
	var tween = get_tree().create_tween().set_parallel(true)
	tween.finished.connect(level_manager.load_dest)
	tween.tween_property(mat1, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat2, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mat3, "albedo_color:a", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)

