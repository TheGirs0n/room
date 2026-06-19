extends Control
class_name SettingsMenu

@export_file("*.tscn") var menu_scene: String


func _ready() -> void:
	get_tree().paused = false


func _on_back() -> void:
	if menu_scene != "":
		get_tree().change_scene_to_file(menu_scene)
