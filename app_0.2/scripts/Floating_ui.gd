extends StaticBody3D

@export var control = Control
var manager 

signal picked
signal picked_2

var looked_at : bool = false : 
	set(looked):
		looked_at = looked



# Called when the node enters the scene tree for the first time.
func _ready():
	control.filled_up.connect(on_filled)
	picked.connect(%ChoicePanels.on_picked)
	picked_2.connect(%ChoicePanels.on_picked_2)

func _process(_delta):
	control.fill = looked_at


func on_filled():
	if control.name == "Target_EN":
		Session.choix_lang = Session.Lang.EN
		emit_signal("picked")
	if control.name == "Target_FR":
		Session.choix_lang = Session.Lang.FR
		emit_signal("picked")
	if control.name == "Target_STFR":
		Session.choix_st = true
		emit_signal("picked_2")
	if control.name == "Target_STEN":
		Session.choix_st = false
		emit_signal("picked_2")
	
