extends Control
class_name TutorialUI

@export var cat: Cat  
@export_file("*.tscn") var next_scene: String  

@onready var hint_label: RichTextLabel = $RichTextLabel
@onready var continue_button: Button = $ContinueButton

enum Step { MOVE, PICKUP, RETURN, INTRO_EYE, INTRO_PAW, COMPLETE }

const HINTS: Dictionary = {
	Step.MOVE:      "TUT_MOVE",
  Step.PICKUP:    "TUT_PICKUP",
  Step.RETURN:    "TUT_RETURN",
  Step.INTRO_EYE: "TUT_EYE",
  Step.INTRO_PAW: "TUT_PAW",
  Step.COMPLETE:  "TUT_COMPLETE"}

var current_step: Step = Step.MOVE


func _ready() -> void:
	cat.disable_eye()
	cat.disable_paw()

	continue_button.hide()

	EventBus.mouse_leave_old_room.connect(_on_leave_room)
	EventBus.mouse_cheese_pickup.connect(_on_cheese_pickup)
	EventBus.mouse_cheese_dropped.connect(_on_cheese_dropped)
	EventBus.mouse_spotted_by_cat.connect(_on_spotted)
	EventBus.mouse_blocked_by_cat.connect(_on_blocked)

	_show_step(Step.MOVE)


func _show_step(step: Step) -> void:
	current_step = step
	hint_label.text = tr(HINTS[step])
	match step:
		Step.INTRO_EYE: cat.enable_eye()
		Step.INTRO_PAW: cat.enable_paw()
		Step.COMPLETE:
			cat.disable_eye()
			cat.disable_paw()
			continue_button.show()


func _on_continue() -> void:
	SaveData.mark_tutorial_done()
	if next_scene != "":
		get_tree().change_scene_to_file(next_scene)


func _on_leave_room(_room_id: int) -> void:
	if current_step == Step.MOVE:
		_show_step(Step.PICKUP)


func _on_cheese_pickup() -> void:
	if current_step == Step.PICKUP:
		_show_step(Step.RETURN)


func _on_cheese_dropped() -> void:
	if current_step == Step.RETURN:
		_show_step(Step.INTRO_EYE)


func _on_spotted() -> void:
	if current_step == Step.INTRO_EYE:
		_show_step(Step.INTRO_PAW)


func _on_blocked() -> void:
	if current_step == Step.INTRO_PAW:
		_show_step(Step.COMPLETE)
