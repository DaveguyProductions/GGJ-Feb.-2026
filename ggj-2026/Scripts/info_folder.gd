extends Sprite2D

@export var suspect_name: String
@export var suspect_image: Texture

const plot1_path = "res://info docs/plot1.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var suspect_data = read_json_file(plot1_path)
	if suspect_data != null:
		$name.text = suspect_name
		$photo_frame/photo_bg/suspect.texture = suspect_image
		if suspect_name == "Marilyn Munias":
			$timeline.text = suspect_data["timeline_marilyn"]
		elif suspect_name == "Sebastian":
			$timeline.text = suspect_data["timeline_sebastian"]
		elif suspect_name == "Roman":
			$timeline.text = suspect_data["timeline_roman"]
		elif suspect_name == "Victoria":
			$timeline.text = suspect_data["timeline_victoria"]
		elif suspect_name == "Mr. Brookesia":
			$timeline.text = suspect_data["timeline_b"]
	else:
		print("null")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func read_json_file(path: String) -> Variant:
	# 1. Open the file in read mode
	if not FileAccess.file_exists(path):
		print("Error: File not found at path: ", path)
		return null

	var file: FileAccess = FileAccess.open(path, FileAccess.READ)

	# 2. Read the entire file content as a string
	var content: String = file.get_as_text()

	# 3. Close the file
	file.close()

	# 4. Parse the JSON string into a Godot data structure
	# parse_string returns a Variant (usually a Dictionary or Array) or null on failure
	var data = JSON.parse_string(content)

	if data == null:
		print("Error: Failed to parse JSON from file: ", path)
		return null

	# 5. Return the parsed data
	return data
