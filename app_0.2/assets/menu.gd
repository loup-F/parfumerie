extends Control
@onready var texture_progress_bar = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/TextureProgressBar
@onready var label = $"../../Label3D"
var fill = true
var last_ui = null
signal filled_up

# Called when the node enters the scene tree for the first time.
func _ready():
	filled_up.connect(label._on_progress_filled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if fill == true :
		texture_progress_bar.value += 1
	elif texture_progress_bar.value < texture_progress_bar.max_value:
		texture_progress_bar.value -=3
	else: 
		emit_signal("filled_up")

func empty():
	fill = false

func fill_up():
	fill = true

func _on_raycast_ui_found(ui):
	ui.set_looked_at(true)
	last_ui = ui
	

func _on_raycast_ui_lost():
	if last_ui !=null:
		last_ui.set_looked_at(false)
