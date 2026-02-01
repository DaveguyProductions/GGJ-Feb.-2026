extends CanvasLayer

var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_notes") and globals.file_access == true:
		show()
	
	hide_all()
	get_child(current_index).show()

func hide_all():
	for i in 5:
		get_child(i).hide()

func _on_button_left_pressed() -> void:
	if current_index > 0:
		current_index -= 1
	else:
		current_index = 4
		
func _on_button_right_pressed() -> void:
	if current_index < 4:
		current_index += 1
	else:
		current_index = 0


func _on_close_pressed() -> void:
	hide()
