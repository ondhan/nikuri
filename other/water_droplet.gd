extends Node2D


var droplet_phase = 1
var water_value = 20


func _ready() -> void:
	pass


func dry() -> void:
	if droplet_phase == 3:
		queue_free()
	else:
		droplet_phase+=1
		if droplet_phase == 2:
			$Area2D/AnimatedSprite2D.animation = "2_medium"
			$Area2D/CollisionShape2D.hide()
			$Area2D/CollisionShape2D2.show()
			water_value/=2
		elif droplet_phase == 3:
			$Area2D/AnimatedSprite2D.animation = "3_small"
			$Area2D/CollisionShape2D2.hide()
			$Area2D/CollisionShape2D3.show()
			water_value/=2


func _on_timer_timeout() -> void:
	dry()

func _on_droplet_body_entered(body: Node2D) -> void:
	get_parent()._on_droplet_body_entered()
	queue_free()
