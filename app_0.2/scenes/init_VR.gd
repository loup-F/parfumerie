extends Node3D

signal focus_lost
signal focus_gained
signal pose_recentered

@export var maximum_refresh_rate : int = 90
#@export var first_scene_to_load : path

var xr_interface : OpenXRInterface
var xr_is_focussed = false

var level_instance : Node3D
var start = preload("res://scenes/start_menu.tscn")
var main = preload("res://scenes/main.tscn")


func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	var vp : Viewport = get_viewport()
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR instantiated successfully.")

		# Enable XR on our viewport
		vp.use_xr = true
		# Make sure v-sync is off, v-sync is handled by OpenXR
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Connect the OpenXR events
		xr_interface.connect("session_begun", _on_openxr_session_begun)
		xr_interface.connect("session_visible", _on_openxr_visible_state)

	else:
		# We couldn't start OpenXR.
		print("OpenXR not instantiated!")
#		get_tree().quit()
		vp.use_xr = false
		
	load_start_menu()
#	load_main()

func _on_openxr_session_begun() -> void:
	# Get the reported refresh rate
	var current_refresh_rate = xr_interface.get_display_refresh_rate()
	if current_refresh_rate > 0:
		print("OpenXR: Refresh rate reported as ", str(current_refresh_rate))
	else:
		print("OpenXR: No refresh rate given by XR runtime")

	# See if we have a better refresh rate available
	var new_rate = current_refresh_rate
	var available_rates : Array = xr_interface.get_available_display_refresh_rates()
	if available_rates.size() == 0:
		print("OpenXR: Target does not support refresh rate extension")
	elif available_rates.size() == 1:
		# Only one available, so use it
		new_rate = available_rates[0]
	else:
		for rate in available_rates:
			if rate > new_rate and rate <= maximum_refresh_rate:
				new_rate = rate

	# Did we find a better rate?
	if current_refresh_rate != new_rate:
		print("OpenXR: Setting refresh rate to ", str(new_rate))
		xr_interface.set_display_refresh_rate(new_rate)
		current_refresh_rate = new_rate

	# Now match our physics rate
	Engine.physics_ticks_per_second = current_refresh_rate
	
# Handle OpenXR visible state
func _on_openxr_visible_state() -> void:
	# We always pass this state at startup,
	# but the second time we get this it means our player took off their headset
	if xr_is_focussed:
		print("OpenXR lost focus")

		xr_is_focussed = false

		# pause our game
		process_mode = Node.PROCESS_MODE_DISABLED

		emit_signal("focus_lost")

# Handle OpenXR focused state
func _on_openxr_focused_state() -> void:
	print("OpenXR gained focus")
	xr_is_focussed = true

	# unpause our game
	process_mode = Node.PROCESS_MODE_INHERIT
	get_tree ().reload_current_scene ()

	emit_signal("focus_gained")

func unload_level():
	print(level_instance)
	if (is_instance_valid(level_instance)):
		print("is valid ", level_instance)
		level_instance.free() #if theres a bug its probably here
		level_instance = null
		print("post free ", level_instance)

func load_level(level_name : String):
	unload_level()
	var level_path := "res://scenes/%s.tscn" % level_name
	var level_resource = load(level_path)
	if level_resource :
		level_instance = level_resource.instantiate()
		add_child(level_instance)

func load_main():
	unload_level()
	if main :
		level_instance = main.instantiate()
		add_child(level_instance)

func load_start_menu():
	unload_level()
	if start :
		level_instance = start.instantiate()
		add_child(level_instance)
