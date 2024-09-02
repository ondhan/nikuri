extends Area2D


@export var speed = 400 # how fast the player will move (pixels/sec)
var screen_size # size of the game window
var last_move_anim # last movement animation used


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		if last_move_anim == "right":
			$AnimatedSprite2D.animation = "idle_left"
		elif last_move_anim == "left":
			$AnimatedSprite2D.animation = "idle_left"
		elif last_move_anim == "down":
			$AnimatedSprite2D.animation = "idle_down"
		elif last_move_anim == "up":
			$AnimatedSprite2D.animation = "idle_up"
	
	position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "move_left"
			last_move_anim = "right"
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "move_left"
			last_move_anim = "left"
	elif velocity.y != 0:
		if Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "move_down"
			last_move_anim = "down"
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "move_up"
			last_move_anim = "up"
