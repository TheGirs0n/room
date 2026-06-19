extends Node

signal mouse_enter_new_room(new_room : int)
signal mouse_leave_old_room(old_room : int)

signal cheese_count_update(new_count : int)
signal mouse_cheese_pickup
signal mouse_cheese_dropped

signal mouse_spotted_by_cat
signal mouse_blocked_by_cat

signal room_spotted(room_id : int)
signal cheese_delivered
signal level_completed
