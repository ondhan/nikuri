extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = get_viewport_rect().size/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")