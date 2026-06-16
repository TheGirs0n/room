extends Control
class_name ResultScreen

@onready var title_label: Label = $Background/VBox/TitleLabel
@onready var action_button: Button = $Background/VBox/ActionButton

signal confirmed


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	action_button.pressed.connect(_on_action_pressed)


func _on_action_pressed() -> void:
	confirmed.emit()


func show_result(title: String, button_text: String) -> void:
	title_label.text = title
	action_button.text = button_text
	show()
