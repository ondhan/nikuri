extends CharacterBody2D


# variables
@export var speed = 400 # how fast the player will move (pixels/sec)
var screen_size # size of the game window
var last_move_anim # last movement animation used


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# basic four directional movement
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# sets idle animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		if last_move_anim == "e":
			print("idling east")
			$AnimatedSprite2D.animation = "idle_e"
		elif last_move_anim == "ne":
			print("idling northeast")
			$AnimatedSprite2D.animation = "idle_ne"
		elif last_move_anim == "se":
			print("idling southeast")
			$AnimatedSprite2D.animation = "idle_se"
		elif last_move_anim == "w":
			print("idling west")
			$AnimatedSprite2D.animation = "idle_w"
		elif last_move_anim == "nw":
			print("idling northwest")
			$AnimatedSprite2D.animation = "idle_nw"
		elif last_move_anim == "sw":
			print("idling southwest")
			$AnimatedSprite2D.animation = "idle_sw"
		elif last_move_anim == "s":
			print("idling south")
			$AnimatedSprite2D.animation = "idle_s"
		elif last_move_anim == "n":
			print("idling north")
			$AnimatedSprite2D.animation = "idle_n"
	
	# changes player position
	position += velocity * delta
	
	# sets movement animation
	if velocity.x != 0 and velocity.y == 0:
		if Input.is_action_pressed("move_right"):
			print("moving east")
			$AnimatedSprite2D.animation = "move_e"
			last_move_anim = "e"
		if Input.is_action_pressed("move_left"):
			print("moving west")
			$AnimatedSprite2D.animation = "move_w"
			last_move_anim = "w"
	elif velocity.x == 0 and velocity.y != 0:
		if Input.is_action_pressed("move_down"):
			print("moving south")
			$AnimatedSprite2D.animation = "move_s"
			last_move_anim = "s"
		if Input.is_action_pressed("move_up"):
			print("moving north")
			$AnimatedSprite2D.animation = "move_n"
			last_move_anim = "n"
	elif velocity.x != 0 and velocity.y != 0:
		if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
			print("moving southwest")
			$AnimatedSprite2D.animation = "move_sw"
			last_move_anim = "sw"
		if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
			print("moving southeast")
			$AnimatedSprite2D.animation = "move_se"
			last_move_anim = "se"
		if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
			print("moving northwest")
			$AnimatedSprite2D.animation = "move_nw"
			last_move_anim = "nw"
		if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
			print("moving northeast")
			$AnimatedSprite2D.animation = "move_ne"
			last_move_anim = "ne"


# manages collisions
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		print("collision with an object")
		velocity = velocity.bounce(collision_info.get_normal())
