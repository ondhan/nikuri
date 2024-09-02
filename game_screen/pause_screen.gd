extends Node2D

var was_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _input(event):
	if event.is_action_pressed("ui_pause"):
		print("unpausing game on Esc key")
		_unpause_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _pause_game():
	print("game paused")
	get_tree().paused = true
	was_paused = true
	show()


func _unpause_game():
	print("game unpaused")
	get_tree().paused = false
	hide()


func _on_resume_button_pressed() -> void:
	print("resume button pressed")
	_unpause_game()


func _on_main_menu_button_pressed() -> void:
	print("main menu button pressed")
	_unpause_game()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
