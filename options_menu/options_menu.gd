extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Window mode button
	var menuButton1 = $WindowModeButton
	var popup_window_mode=menuButton1.get_popup()
	popup_window_mode.id_pressed.connect(_on_window_menu_button_pressed)
	# Test button
	var menuButton2 = $MenuButton
	var popup_test=menuButton2.get_popup()
	popup_test.id_pressed.connect(_on_test_menu_button_pressed)

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
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_test_menu_button_pressed(id) -> void:
	match(id):
		0: 
			print("A")
		1: 
			print("B")
