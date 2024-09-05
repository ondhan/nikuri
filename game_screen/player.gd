extends CharacterBody2D


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
		if last_move_anim == "e":
			$AnimatedSprite2D.animation = "idle_w"
		elif last_move_anim == "ne":
			$AnimatedSprite2D.animation = "idle_nw"
		elif last_move_anim == "se":
			$AnimatedSprite2D.animation = "idle_sw"
		elif last_move_anim == "w":
			$AnimatedSprite2D.animation = "idle_w"
		elif last_move_anim == "nw":
			$AnimatedSprite2D.animation = "idle_nw"
		elif last_move_anim == "sw":
			$AnimatedSprite2D.animation = "idle_sw"
		elif last_move_anim == "s":
			$AnimatedSprite2D.animation = "idle_s"
		elif last_move_anim == "n":
			$AnimatedSprite2D.animation = "idle_n"
	
	position += velocity * delta
	
	if velocity.x != 0 and velocity.y == 0:
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "move_w"
			last_move_anim = "e"
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "move_w"
			last_move_anim = "w"
	elif velocity.x == 0 and velocity.y != 0:
		if Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "move_s"
			last_move_anim = "s"
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "move_n"
			last_move_anim = "n"
	elif velocity.x != 0 and velocity.y != 0:
		if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "move_sw"
			last_move_anim = "sw"
		if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "move_sw"
			last_move_anim = "se"
		if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "move_nw"
			last_move_anim = "nw"
		if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "move_nw"
			last_move_anim = "ne"

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		print("collision with an object")
		velocity = velocity.bounce(collision_info.get_normal())
