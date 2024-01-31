extends Control
@onready var progress_bar = $MarginContainer2/VBoxContainer/TextureProgressBar
@onready var UI = $"../../3D_UI"
var fill = false
var last_ui = null
var filled = false
signal filled_up

# connect signals
func _ready():
	filled_up.connect(UI._on_progress_filled)


# gère le remplissage de la barre en et emet un signal si elle est pleine
func _process(_delta):
	if progress_bar.value == progress_bar.max_value and filled == false:
		filled = true
		emit_signal("filled_up")
	elif fill == true :
		progress_bar.value += 1
	else :
		progress_bar.value -=3
		filled = false

func _on_raycast_ui_found(ui):
	ui.set_looked_at(true)
	last_ui = ui

func _on_raycast_ui_lost():
	if last_ui !=null:
		last_ui.set_looked_at(false)
