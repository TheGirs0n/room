extends Node2D
class_name RoomLinks
# Рисует «коридоры» между связанными комнатами (читаемость графа уровня).

@export var line_color : Color = Color(0.36, 0.39, 0.47, 0.7)
@export var line_width : float = 8.0


# rooms — массив комнат уровня (Array[Room])
func build(rooms : Array) -> void:
	z_index = -1  # коридоры рисуются под комнатами
	var drawn := {}
	for room in rooms:
		for linked in room.room_linked_array:
			if linked == null:
				continue
			var key := _pair_key(room, linked)
			if drawn.has(key):
				continue  # каждое ребро один раз
			drawn[key] = true

			var line := Line2D.new()
			line.width = line_width
			line.default_color = line_color
			line.begin_cap_mode = Line2D.LINE_CAP_ROUND
			line.end_cap_mode = Line2D.LINE_CAP_ROUND
			line.joint_mode = Line2D.LINE_JOINT_ROUND
			line.points = PackedVector2Array([room.position, linked.position])
			add_child(line)


func _pair_key(a : Node, b : Node) -> String:
	var ia := a.get_instance_id()
	var ib := b.get_instance_id()
	return "%d_%d" % [mini(ia, ib), maxi(ia, ib)]
