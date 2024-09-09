extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_sun_value(value):
	$SunProgressBar.value = value


func set_water_value(value):
	$WaterProgressBar.value = value


func set_biomass_value(value):
	$BiomassProgressBar.value = value
