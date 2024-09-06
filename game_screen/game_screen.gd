extends Node2D

var time = "day"

# called when the node enters the scene tree for the first time
func _ready() -> void:
	_set_time()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	var PauseScreen = get_node("Camera/CanvasLayer/PauseScreen")
	if event.is_action_pressed("ui_pause") and not PauseScreen.was_paused:
		print("calling pause game on Esc key")
		PauseScreen._pause_game()
	else:
		PauseScreen.was_paused = false;


func _on_pause_button_pressed() -> void:
	print("calling pause game on pause button")
	get_node("Camera/CanvasLayer/PauseScreen")._pause_game()


# sets the correct day/night icon when loading the scene
func _set_time() -> void:
	if time == "day":
		$Camera/CanvasLayer/DayIcon.show()
	elif time == "night":
		$Camera/CanvasLayer/NightIcon.show()


# changes day to night once timer stops
func _on_timer_timeout() -> void:
	if time == "day":
		print("switching to night")
		time = "night"
		$Camera/CanvasLayer/DayIcon.hide()
		$Camera/CanvasLayer/NightIcon.show()
	else:
		print("switching to day")
		time = "day"
		$Camera/CanvasLayer/DayIcon.show()
		$Camera/CanvasLayer/NightIcon.hide()
