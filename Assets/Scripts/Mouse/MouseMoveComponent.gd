extends Node
class_name MouseMoveComponent

var current_room : Room

var movement_tween : Tween
var mouse_main : MouseMain

var mouse_is_moving : bool

func setup(mouse : MouseMain):
	mouse_main = mouse
	mouse_is_moving = false
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key = OS.get_keycode_string(event.keycode).to_lower()[-1]
		move_another_room(key)
	
# движение к другой комнате
func move_another_room(next_room_id : int):
	if !mouse_is_moving:
		if next_room_id in current_room.room_linked_array:
			mouse_is_moving = true
			EventBus.mouse_leave_old_room.emit(current_room.room_id)
			current_room = current_room.get_linked_room_by_id(next_room_id)
			
			movement_tween = create_tween()
			movement_tween.set_ease(Tween.EASE_IN_OUT)
			movement_tween.set_trans(Tween.TRANS_CUBIC)
			movement_tween.tween_property(mouse_main, "global_position", current_room.global_position, 1)
			movement_tween.finished.connect(movement_tween_end)

	
func movement_tween_end():
	EventBus.mouse_enter_new_room.emit(current_room.room_id)

	if current_room.is_escape_room:
		mouse_main.mouse_pickup_component.mouse_drop_cheese()

	mouse_is_moving = false
