extends CharacterBody2D

@onready var map = get_node("../Platforming_0")

const SPEED = 175.0
const DASH = 30.0
const TELEPORT = 125.0
const JUMP_VELOCITY = -525.0

const MAX_JUMPS = 2
var curr_jumps = 0

const COOLDOWN_TIME = 5.0
var cooldown = false
var temp_time = 0

var mask_list = [1,2,3]

# 1 = dash, 2 = double jump, 3 = teleport
var curr_mask = 1

var mask_just_switched = false

	
func _physics_process(delta: float) -> void:
	# Add the gravity. 
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var curr_pos = Vector2 (self.position.x, self.position.y)
	
	# Handle cooldown.
	if cooldown:
		temp_time += 0.1 
		if temp_time >= COOLDOWN_TIME or mask_just_switched:
			temp_time = 0
			cooldown = false 
			mask_just_switched = false

	# Handle jump.
	if !curr_mask == 2:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_pressed("Jump") and curr_jumps < MAX_JUMPS:
			curr_jumps += 1
			velocity.y = JUMP_VELOCITY
		if curr_jumps == MAX_JUMPS and is_on_floor():
			curr_jumps = 0
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_vertical := Input.get_axis("Move_Up", "Move_Down")
		
	# Handle dash and teleport 
	if Input.is_action_just_pressed("shift") and !cooldown:
		if curr_mask == 1:
			velocity.x = direction * (SPEED * DASH)
			cooldown = true
			
		
		if curr_mask == 3:
			var x = self.position.x
			var y = self.position.y
			var change_to_x = direction * TELEPORT
			var change_to_y = direction_vertical * TELEPORT
			x = x + change_to_x
			y = y + change_to_y
			var target = Vector2(x, y)
			#var target2 = Vector2()
			var map_coords: Vector2i = map.local_to_map(target)
			var source_id: int = map.get_cell_source_id(map_coords)
			if source_id == -1:
				self.position.x += direction * TELEPORT
				self.position.y += direction_vertical * TELEPORT
				cooldown = true
	
	# Handle mask switching
	var list_position = curr_mask - 1
	if Input.is_action_just_pressed("ui_left"):
		curr_mask = mask_list[list_position - 1]
		mask_just_switched = true
		print(curr_mask)
	if Input.is_action_just_pressed("ui_right"):
		if curr_mask == 3:
			curr_mask = 1
			print(curr_mask)
		else:
			curr_mask = mask_list[list_position + 1]
			mask_just_switched = true
			print(curr_mask)
			
	# Handle Camera when in the attic
	if self.position.y < 1500:
		$Camera2D.limit_left = 7921
		$Camera2D.limit_right = 11184
	if self.position.y > 1500:
		$Camera2D.limit_right = 18672
		$Camera2D.limit_left = 0

	move_and_slide()
