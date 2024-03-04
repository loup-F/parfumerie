extends Control
var fill = false
var filled = false
signal filled_up


# gère le remplissage de la barre en et emet un signal si elle est pleine
func _process(_delta):
	if %ProgressBar.value == %ProgressBar.max_value and filled == false:
		filled = true
		emit_signal("filled_up")
	elif fill == true :
		%ProgressBar.value += 1
	else :
		%ProgressBar.value -=3
		filled = false
