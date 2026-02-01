extends Area2D

@export var suspect_name: String
@export var suspect_texture: Texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$suspect_collider/suspect_sprite.texture = suspect_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if globals.read_files == true:
			body.current_suspect(suspect_name)
			globals.near_suspect = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_node("speech_bubble").hide()
		body.get_node("speech_text2").hide()
		globals.near_suspect = false
