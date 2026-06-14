extends Node
class_name MouseMoveComponent

var current_room : Room

var movement_tween : Tween
var mouse_main : MouseMain

var mouse_is_moving : bool

func setup(mouse : MouseMain):
	mouse_main = mouse
	mouse_is_moving = false
	
	
func set_start_room(start_room : Room):
	current_room = start_room
	mouse_main.global_position = current_room.global_position
	movement_tween_end()
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed():
			var key = OS.get_keycode_string(event.keycode).to_lower()[-1] as int
			move_another_room(key)
	
	
func move_another_room(next_room_id : int):
	if !mouse_is_moving:
		if current_room.get_open_room_by_id(next_room_id) != null:
			mouse_is_moving = true
			EventBus.mouse_leave_old_room.emit(current_room.room_id)
			current_room = current_room.get_linked_room_by_id(next_room_id)
			
			if movement_tween:
				movement_tween.kill()
			
			movement_tween = create_tween()
			movement_tween.set_ease(Tween.EASE_IN_OUT)
			movement_tween.set_trans(Tween.TRANS_CUBIC)
			movement_tween.tween_property(mouse_main, "global_position", current_room.global_position, 1)
			movement_tween.finished.connect(movement_tween_end)
		else:
			# комната заблокирована или не существует
			var target = current_room.get_linked_room_by_id(next_room_id)
			if target != null and target.is_block_by_cat:
				EventBus.mouse_blocked_by_cat.emit()
	
func movement_tween_end() -> void:
	EventBus.mouse_enter_new_room.emit(current_room.room_id)

	if current_room.is_spot_by_cat:
		EventBus.mouse_spotted_by_cat.emit()  

	if current_room.is_escape_room:
		mouse_main.mouse_pickup_component.mouse_drop_cheese()

	mouse_is_moving = false
