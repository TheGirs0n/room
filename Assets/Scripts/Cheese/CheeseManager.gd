extends Node
class_name CheeseManager

var all_cheese_array : Array[Cheese]

func cheese_register(cheese: Cheese) -> void:
	all_cheese_array.append(cheese)
	cheese.tree_exiting.connect(func():
		all_cheese_array.erase(cheese)
		EventBus.cheese_count_update.emit(all_cheese_array.size())
	)
