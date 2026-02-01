extends Area2D

@export var evidence_texture: Texture
@export var evidence_id: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$evidence_collider/evidence_sprite.texture = evidence_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		globals.evidence_list.erase(evidence_id)
		print(globals.evidence_list.size())
		queue_free()
