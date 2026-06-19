extends Control
class_name MainMenuUI

@export var first_level: PackedScene
@export var settings_scene: PackedScene

@onready var play_button: Button = $VBox/PlayButton
@onready var settings_button: Button = $VBox/SettingsButton


func _ready() -> void:
	get_tree().paused = false


func _on_play() -> void:
	if first_level:
		get_tree().change_scene_to_packed(first_level)


func _on_settings() -> void:
	if settings_scene:
		get_tree().change_scene_to_packed(settings_scene)
