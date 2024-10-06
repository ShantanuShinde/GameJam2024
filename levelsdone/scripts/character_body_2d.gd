extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -500.0

const gravity = 24.0

const wall_jump_pushback = 100

const wall_slide_friction = 100
var is_wall_sliding = false

var slipperyness = 1

var can_control : bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if not can_control: return # when dieded :(
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handles jump and wall sliding
	jump()
	wall_slide(delta)
	
	
	
	# Input directions -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flips sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	
	if direction:
		velocity.x = direction * SPEED * slipperyness
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/slipperyness)
	
	move_and_slide()
	
func jump():
	velocity.y += gravity
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall() and Input.is_action_pressed("move_right"):
			velocity.y = JUMP_VELOCITY
			velocity.x = -wall_jump_pushback
		if is_on_wall() and Input.is_action_pressed("move_left"):
			velocity.y = JUMP_VELOCITY
			velocity.x = wall_jump_pushback
			
func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	if is_wall_sliding:
		velocity.y += (wall_slide_friction*delta)
		velocity.y = min(velocity.y, wall_slide_friction)
		


func _on_inteaction_area_area_entered(area: Area2D) -> void:
	slipperyness = area.slipperyness


func _on_inteaction_area_area_exited(area: Area2D) -> void:
	slipperyness = 1






	
