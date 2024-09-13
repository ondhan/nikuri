extends Node2D


var time = "day"
var day = 1


func _ready() -> void:
	_set_time()
	spawn_water(4)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_pause"):
		print("Esc key")
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
func _on_day_cycle_timer_timeout() -> void:
	if time == "day":
		#print("switching to night")
		time = "night"
		$Camera/CanvasLayer/DayIcon.hide()
		$Camera/CanvasLayer/NightIcon.show()
	else:
		#print("switching to day")
		time = "day"
		$Camera/CanvasLayer/DayIcon.show()
		$Camera/CanvasLayer/NightIcon.hide()
		spawn_water(3+day)


func _on_seconds_timer_timeout() -> void:
	if time == "day":
		$MainHive._resource_counter_change("sun", 0.5)


func spawn_water(num):
	var rand = RandomNumberGenerator.new()
	var droplet_scene = load("res://other/water_droplet.tscn")
	
	for droplet_instance in num:
		var droplet = droplet_scene.instantiate()
		rand.randomize()
		var x = rand.randf_range(-2750, 2750) 
		rand.randomize()
		var y = rand.randf_range(-1500, 1500) 
		droplet.position.x = x
		droplet.position.y = y
		add_child(droplet)


func _on_droplet_body_entered() -> void:
	$MainHive._resource_counter_change("water", $WaterDroplet.water_value)
