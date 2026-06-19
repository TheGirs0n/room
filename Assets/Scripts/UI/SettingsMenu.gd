extends Control
class_name SettingsMenu

@export var menu_scene: PackedScene

@onready var back_button: Button = $VBox/BackButton


func _ready() -> void:
	get_tree().paused = false


func _on_back() -> void:
	if menu_scene:
		get_tree().change_scene_to_packed(menu_scene)
