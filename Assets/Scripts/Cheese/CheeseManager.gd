extends Node
class_name CheeseManager

@export var all_cheese_array : Array[Cheese]

func _ready() -> void:
	EventBus.mouse_pickup_cheese.connect(cheese_count_update)


func cheese_count_update():
	EventBus.cheese_count_update.emit(all_cheese_array.size())
