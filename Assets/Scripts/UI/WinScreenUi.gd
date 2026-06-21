extends Control
class_name WinScreen

@export_file("*.tscn") var menu_scene: String
@export_file("*.tscn") var first_level: String


func _ready() -> void:
	get_tree().paused = false
	MusicPlayer.play(preload("res://Assets/Audio/Music/Monkeys Spinning Monkeys.mp3"))


func _on_menu() -> void:
	if menu_scene != "":
		get_tree().change_scene_to_file(menu_scene)


func _on_restart() -> void:
	if first_level != "":
		get_tree().change_scene_to_file(first_level)
