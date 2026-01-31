extends CharacterBody2D


const SPEED = 300.0
const DASH = 100.0
const TELEPORT = 250.0
const JUMP_VELOCITY = -400.0

const MAX_JUMPS = 2
var curr_jumps = 0

var has_mask_dash = true
var has_mask_doublejump = false
var has_mask_teleport = false

const COOLDOWN_TIME = 5.0
var cooldown = false
var temp_time = 0

# 1 = dash, 2 = double jump, 3 = teleport
var curr_mask = 3

func _physics_process(delta: float) -> void:
	# Add the gravity. 
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle cooldown.
	if cooldown:
		temp_time += 0.1 
		if temp_time >= COOLDOWN_TIME: # or mask_change():
			temp_time = 0
			cooldown = false 

	# Handle jump.
	if !curr_mask == 2:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_pressed("ui_accept") and curr_jumps < MAX_JUMPS:
			curr_jumps += 1
			velocity.y = JUMP_VELOCITY
		if curr_jumps == MAX_JUMPS and is_on_floor():
			curr_jumps = 0
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle dash and teleport 
	if Input.is_action_just_pressed("shift") and !cooldown:
		if curr_mask == 1:
			velocity.x = direction * (SPEED * DASH)
			cooldown = true
		if curr_mask == 3:
			self.position.x += direction * TELEPORT
			cooldown = true

	move_and_slide()
