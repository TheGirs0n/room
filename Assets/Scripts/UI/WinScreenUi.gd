extends Control
class_name WinScreen

@export var menu_scene: PackedScene
@export var first_level: PackedScene

@onready var menu_button: Button = $VBox/MenuButton
@onready var restart_button: Button = $VBox/RestartButton


func _ready() -> void:
	get_tree().paused = false


func _on_menu() -> void:
	if menu_scene:
		get_tree().change_scene_to_packed(menu_scene)


func _on_restart() -> void:
	if first_level:
		get_tree().change_scene_to_packed(first_level)
