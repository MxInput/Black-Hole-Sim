extends Node

@export var camera : Camera2D;

@export var main_screen : Node;
@export var black_hole_screen : Node;

var contact := false;
var current_screen : Node;

var target_pos : Vector2;
var finished := true;

var offset := Vector2(576, 324);
var time := 0.0;

func move_camera() -> void:
	if (!contact):
		var background = current_screen.find_child("Background");
		target_pos = background.position;
		finished = false;

func _ready() -> void:
	current_screen = main_screen;
	
func _process(delta: float) -> void:
	time += delta/8;
	
	if (!finished):
		var new_pos = lerp(camera.position, (target_pos + offset), time);
		camera.position = new_pos;
		
		if (current_screen == black_hole_screen):
			if (camera.position.x >= (target_pos + offset).x):
				camera.position = (target_pos + offset);
				current_screen = null;
				finished = true;
				time = 0.0;
		else:
			if (camera.position.x <= (target_pos + offset).x):
				camera.position = (target_pos + offset);
				current_screen = null;
				finished = true;
				time = 0.0;
	
func _on_left_collider_mouse_entered() -> void:
	if (current_screen != main_screen):
		current_screen = main_screen;
	
	if (finished):
		move_camera();
	
	contact = true;

func _on_right_collider_mouse_entered() -> void:
	if (current_screen != black_hole_screen):
		current_screen = black_hole_screen;
	
	if (finished):
		move_camera();
	
	contact = true;
	
func _on_right_collider_mouse_exited() -> void:
	contact = false;

func _on_left_collider_mouse_exited() -> void:
	contact = false;
