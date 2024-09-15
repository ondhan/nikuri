extends Node2D


var last_anim = null
@onready var collision_shape = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("sun_plant_closed")
	collision_shape.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_game_screen_declare_day() -> void:
	if self.is_visible():
		$AnimatedSprite2D.play("sun_plant_opening")
		last_anim = "sun_plant_opening"


func _on_game_screen_declare_night() -> void:
	if self.is_visible():
		$AnimatedSprite2D.play_backwards("sun_plant_opening")
		last_anim = "sun_plant_closing"
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if last_anim == "sun_plant_opening":
		$AnimatedSprite2D.play("sun_plant_open")
	elif last_anim == "sun_plant_closing":
		$AnimatedSprite2D.play("sun_plant_closed")


func _on_sun_plant_timer_timeout() -> void:
	if self.is_visible():
		get_parent().sun_plant_activity()


func _on_visibility_changed() -> void:
	get_parent().what_time()
	collision_shape.set_deferred("disabled", false)
