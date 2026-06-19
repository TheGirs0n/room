extends Control
class_name WinScreen

@export_file("*.tscn") var menu_scene: String
@export_file("*.tscn") var first_level: String


func _ready() -> void:
	get_tree().paused = false


func _on_menu() -> void:
	if menu_scene != "":
		get_tree().change_scene_to_file(menu_scene)


func _on_restart() -> void:
	if first_level != "":
		get_tree().change_scene_to_file(first_level)
