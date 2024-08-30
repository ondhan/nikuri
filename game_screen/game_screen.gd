extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = get_viewport_rect().size/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pause_button_pressed() -> void:
	var PauseScreen = get_node("PauseScreen")
	PauseScreen.set_visible(true)


func _on_resume_button_pressed() -> void:
	var PauseScreen = get_node("PauseScreen")
	PauseScreen.set_visible(false)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
