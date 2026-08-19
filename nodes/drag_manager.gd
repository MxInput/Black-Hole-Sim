extends Node

var current_held_object : Node;

func _process(delta: float) -> void:
	if (current_held_object != null):
		var mouse_pos = current_held_object.get_global_mouse_position();
		var offset = Vector2(current_held_object.size.x/2.0, current_held_object.size.y/2.0);
		
		current_held_object.global_position = (mouse_pos - offset);
