extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Level.tscn")


func _on_credits_pressed() -> void:
	$Button_Manager.visible = false
	$Credit_Screen.visible = true


func _on_back_pressed() -> void:
	$Credit_Screen.visible = false
	$Button_Manager.visible = true
	
