extends StaticBody3D

@export var control = Control

signal picked

var looked_at : bool = false : 
	set(looked):
		looked_at = looked

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(" floating ui ", self, " choicePanel node : ", %ChoicePanels)
	control.filled_up.connect(on_filled)
	picked.connect(%ChoicePanels.on_picked)

func _process(_delta):
	control.fill = looked_at
	$Label3D.visible = looked_at


func on_filled():
	match control.name:
		"Target_EN":
			Session.choix_lang = Session.Lang.EN
		"Target_FR":
			Session.choix_lang = Session.Lang.EN
		"Target_VO":
			Session.choix_lang = Session.Lang.VO
			Session.subtitles = true
	emit_signal("picked")
	
