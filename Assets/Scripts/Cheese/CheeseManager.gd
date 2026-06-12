extends Node
class_name CheeseManager

@export var all_cheese_array : Array[Cheese]

func _ready() -> void:
	EventBus.mouse_cheese_pickup.connect(cheese_count_update)


func cheese_count_update():
	EventBus.cheese_count_update.emit(all_cheese_array.size())


func cheese_register(cheese : Cheese):
	all_cheese_array.append(cheese)
	cheese.tree_exiting.connect(func(): all_cheese_array.erase(cheese))
