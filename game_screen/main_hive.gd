extends Node2D

# indicates base phase
var current_phase = 1
var can_interact = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_phase_setter()

func _input(event):
	if event.is_action_pressed("ui_accept") and can_interact == true:
		_upgrade_hive()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# sets the hive by enabling and disabling appropriate scenes
func _phase_setter() -> void:
	var hive = get_node("Phase1")
	hive.hide()
	if current_phase == 1:
		hive = get_node("Phase1")
		$Phase1/AnimatedSprite2D.animation = "phase_1"
		$Phase1/AnimatedSprite2D.play()
		hive.show()
	elif current_phase == 2:
		hive = get_node("Phase2")
		$Phase2/AnimatedSprite2D.animation = "phase_2"
		$Phase2/AnimatedSprite2D.play()
		hive.show()
	elif current_phase == 3:
		hive = get_node("Phase3")
		$Phase2/AnimatedSprite2D.animation = "phase_3"
		$Phase2/AnimatedSprite2D.play()
		hive.show()
	elif current_phase == 4:
		hive = get_node("Phase4")
		$Phase2/AnimatedSprite2D.animation = "phase_4"
		$Phase2/AnimatedSprite2D.play()
		hive.show()


# upgrades hive and calls the _phase_setter()
func _upgrade_hive() -> void:
	if current_phase != 4:
		current_phase += 1
		_phase_setter()


func _on_interact_area_body_entered(body: Node2D) -> void:
	print("hive interaction enabled")
	can_interact = true


func _on_interact_area_body_exited(body: Node2D) -> void:
	print("hive interaction disabled")
	can_interact = false
