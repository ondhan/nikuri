extends Node2D


class_name MainHive


# indicates base phase
var current_phase = 1
var can_interact_hive = false
var can_interact_biomass = false
var can_interact_upgrade = false
var can_interact_sun_plant = false
var can_interact_win_trophy = false
var currentSun = 0;
var maxSun = 100;
var currentWater = 0;
var maxWater = 100;
var currentBiomass = 0;
var maxBiomass = 100;
var sun_plants = 0
@onready var sun_plant_1 = get_node("SunPlant")
@onready var sun_plant_2 = get_node("SunPlant2")
@onready var sun_plant_3 = get_node("SunPlant3")
@onready var sun_plant_4 = get_node("SunPlant4")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_phase_setter()


# manages player input
func _input(event):
	# main hive upgrade menu
	if event.is_action_pressed("ui_accept") and can_interact_hive == true:
		print("hive menu opened")
		if $ResourceControl.is_visible() == true:
			$ResourceControl.hide()
		else:
			$ResourceControl.show()
	# buy biomass
	if event.is_action_pressed("ui_accept") and can_interact_biomass == true:
		if currentSun >= 20 and currentWater >= 20 and currentBiomass < maxBiomass:
			print("biomass bought")
			_resource_counter_change("sun", -20)
			_resource_counter_change("water",-20)
			_resource_counter_change("biomass", 10)
	# upgrade hive
	if event.is_action_pressed("ui_accept") and can_interact_upgrade == true:
		if current_phase == 1 and currentBiomass == maxBiomass:
			_resource_counter_change("biomass", -100)
			_upgrade_hive()
			print("hive upgraded")
		elif current_phase == 2 and currentBiomass == maxBiomass:
			_resource_counter_change("biomass", -100)
			_upgrade_hive()
			print("hive upgraded")
		elif current_phase == 3 and currentBiomass == maxBiomass:
			_resource_counter_change("biomass", -100)
			_upgrade_hive()
			print("hive upgraded")
			$ResourceControl/HiveGrowInteractArea.hide()
	# buy sun plant
	if event.is_action_pressed("ui_accept") and can_interact_sun_plant == true and currentBiomass >= 50:
		if sun_plants != 4:
			_resource_counter_change("biomass", -50)
			sun_plants+=1
			get_parent().buy_sun_plant(sun_plants)
			if sun_plants == 4:
				$ResourceControl/SunPlantInteractArea.hide()
	# win game
	if event.is_action_pressed("ui_accept") and can_interact_win_trophy and current_phase == 4:
		get_parent().win_game()
	#if event.is_action_pressed("TEST"):
	#	_resource_counter_change("biomass", 100)


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
	elif current_phase == 2:
		hive = get_node("Phase2")
		$Phase2/AnimatedSprite2D.animation = "phase_2"
		$Phase2/AnimatedSprite2D.play()
	elif current_phase == 3:
		hive = get_node("Phase3")
		$Phase2/AnimatedSprite2D.animation = "phase_3"
		$Phase2/AnimatedSprite2D.play()
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


# detects player in range
func _on_interact_area_body_entered(body: Node2D) -> void:
	print("hive interaction enabled")
	can_interact_hive = true


# detects player no longer in range
func _on_interact_area_body_exited(body: Node2D) -> void:
	print("hive interaction disabled")
	can_interact_hive = false


# changes resource count
func _resource_counter_change(resource, change):
	if resource == "sun":
		currentSun += change
		if currentSun > maxSun:
			currentSun = maxSun
		var sunBarProgress = (maxSun/100) * currentSun
		$ResourceControl.set_sun_value(sunBarProgress)
	if resource == "water":
		currentWater += change
		if currentWater > maxWater:
			currentWater = maxWater
		var waterBarProgress = (maxWater/100) * currentWater
		$ResourceControl.set_water_value(waterBarProgress)
	if resource == "biomass":
		currentBiomass += change
		if currentBiomass > maxBiomass:
			currentBiomass = maxBiomass
		var biomassBarProgress = (maxBiomass/100) * currentBiomass
		$ResourceControl.set_biomass_value(biomassBarProgress)


func _on_biomass_interact_area_body_entered(body: Node2D) -> void:
	can_interact_biomass = true
	print("biomass upgrade enabled")


func _on_biomass_interact_area_body_exited(body: Node2D) -> void:
	can_interact_biomass = false
	print("biomass upgrade disabled")


func _on_hive_grow_interact_area_body_entered(body: Node2D) -> void:
	can_interact_upgrade = true
	print("hive upgrade enabled")


func _on_hive_grow_interact_area_body_exited(body: Node2D) -> void:
	can_interact_upgrade = false
	print("hive upgrade disabled")


func _on_area_2d_body_exited(body: Node2D) -> void:
	$ResourceControl.hide()


func _on_sun_plant_interact_area_body_entered(body: Node2D) -> void:
	can_interact_sun_plant = true
	print("sun plant upgrade disabled")

func _on_sun_plant_interact_area_body_exited(body: Node2D) -> void:
	can_interact_sun_plant = false
	print("sun plant upgrade disabled")


func _on_win_trophy_interact_area_body_entered(body: Node2D) -> void:
	can_interact_win_trophy = true
	print("sun plant upgrade disabled")


func _on_win_trophy_interact_area_body_exited(body: Node2D) -> void:
	can_interact_win_trophy = false
	print("sun plant upgrade disabled")
