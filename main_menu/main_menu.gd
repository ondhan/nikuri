extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	print("play button pressed")
	get_tree().change_scene_to_file("res://game_screen/game_screen.tscn")


func _on_options_button_pressed() -> void:
	print("options button pressed")
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
