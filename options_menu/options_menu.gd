extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# window mode button setup
	var menuButton1 = $WindowModeButton
	var popup_window_mode=menuButton1.get_popup()
	popup_window_mode.id_pressed.connect(_on_window_menu_button_pressed)
	# sets the initial text on the window mode button based on the starting mode
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		get_node("WindowModeButton").text = "Fullscreen"
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		get_node("WindowModeButton").text = "Windowed"
	# test button setup
	#var menuButton2 = $MenuButton
	#var popup_test=menuButton2.get_popup()
	#popup_test.id_pressed.connect(_on_test_menu_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	print("back button pressed")
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_window_menu_button_pressed(id) -> void:
	print(id)
	match(id):
		0: 
			print("switching to fullscreen")
			get_node("WindowModeButton").text = "Fullscreen"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: 
			print("switching to windowed")
			get_node("WindowModeButton").text = "Windowed"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


#func _on_test_menu_button_pressed(id) -> void:
#	match(id):
#		0: 
#			print("A")
#		1: 
#			print("B")
