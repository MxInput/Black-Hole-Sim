extends Node

@export var drag_manager : Node;
@export var spawn_manager : Node;

@export var final_container : Control;
@export var explosions : Control;

func _process(delta: float) -> void:
	final_container.rotation += 0.05;
	var center = final_container.global_position;
	
	for item in final_container.get_children():
		if (item.global_position != center):
			item.self_modulate.a -= .003;
			if (item.global_position.y > center.y):
				item.global_position.y -= 1;
			elif (item.global_position.y < center.y):
				item.global_position.y += 1;
				
			if (item.global_position.x > center.x):
				item.global_position.x -= 1;
			elif (item.global_position.x < center.x):
				item.global_position.x += 1;
				
			if (absf(item.global_position.y - center.y) < 5.0 && absf(item.global_position.y - center.y) > -5.0):
				if (absf(item.global_position.x - center.x) < 5.0 && absf(item.global_position.x - center.x) > -5.0):
					item.global_position = center;
		else:
			var found_explosion = item.find_child("Explosion", true, false);
			found_explosion.reparent(explosions);
			found_explosion.emitting = true;
			
			item.queue_free();
			spawn_manager.num_objects -= 1;
				
