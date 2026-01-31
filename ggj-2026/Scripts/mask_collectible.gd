extends Area2D

@export var mask_name: String
@export var texture_input: Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$mask_texture.Texture = texture_input

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
