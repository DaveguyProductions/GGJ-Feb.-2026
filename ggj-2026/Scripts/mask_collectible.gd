extends Area2D

@export var mask_id: int
@export var texture_input: Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$mask_collider/mask_texture.texture = texture_input

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.add_mask(mask_id)
		queue_free()
