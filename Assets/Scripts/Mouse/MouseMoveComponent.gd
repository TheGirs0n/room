extends Node
class_name MouseMoveComponent

var current_room : Room

var movement_tween : Tween
var mouse_main : MouseMain

var mouse_is_moving : bool


func _ready() -> void:
	EventBus.room_spotted.connect(_on_room_spotted)


func _on_room_spotted(room_id : int) -> void:
	# кот засветил комнату, в которой мышь уже стоит
	if not mouse_is_moving and current_room != null and room_id == current_room.room_id:
		EventBus.mouse_spotted_by_cat.emit()


func setup(mouse : MouseMain):
	mouse_main = mouse
	mouse_is_moving = false
	
	
func set_start_room(start_room : Room):
	current_room = start_room
	mouse_main.global_position = current_room.global_position
	movement_tween_end()
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.echo:
		var room_id := _keycode_to_digit(event.keycode)
		if room_id != -1:
			move_another_room(room_id)


func _keycode_to_digit(keycode: int) -> int:
	if keycode >= KEY_0 and keycode <= KEY_9:
		return keycode - KEY_0
	if keycode >= KEY_KP_0 and keycode <= KEY_KP_9:
		return keycode - KEY_KP_0
	return -1


func move_another_room(next_room_id : int):
	if mouse_is_moving:
		return

	var target = current_room.get_linked_room_by_id(next_room_id)
	if target == null:
		# такой соседней комнаты нет
		return

	if current_room.is_block_by_cat and target.is_block_by_cat:
		# комната заблокирована котом
		EventBus.mouse_blocked_by_cat.emit()
		return

	mouse_is_moving = true
	EventBus.mouse_leave_old_room.emit(current_room.room_id)
	current_room = target

	if movement_tween:
		movement_tween.kill()

	movement_tween = create_tween()
	movement_tween.set_ease(Tween.EASE_IN_OUT)
	movement_tween.set_trans(Tween.TRANS_CUBIC)
	movement_tween.tween_property(mouse_main, "global_position", current_room.global_position, 1)
	movement_tween.finished.connect(movement_tween_end)


func movement_tween_end() -> void:
	EventBus.mouse_enter_new_room.emit(current_room.room_id)

	if current_room.is_spot_by_cat:
		EventBus.mouse_spotted_by_cat.emit()  

	if current_room.is_escape_room:
		mouse_main.mouse_pickup_component.mouse_deliver_cheese()

	mouse_is_moving = false
