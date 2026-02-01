extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if globals.evidence_list.size() == 0:
			$speech_bubble.show()
			globals.file_access = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$speech_bubble.hide()
		globals.file_access = false
