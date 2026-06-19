extends Control
class_name MainMenuUI

@export_file("*.tscn") var first_level: String
@export_file("*.tscn") var tutorial_scene: String
@export_file("*.tscn") var settings_scene: String


func _ready() -> void:
	get_tree().paused = false


func _on_play() -> void:
	if not SaveData.tutorial_done and tutorial_scene != "":
		get_tree().change_scene_to_file(tutorial_scene)
	elif first_level != "":
		get_tree().change_scene_to_file(first_level)


func _on_settings() -> void:
	if settings_scene != "":
		get_tree().change_scene_to_file(settings_scene)
