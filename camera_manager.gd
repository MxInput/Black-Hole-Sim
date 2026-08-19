extends Node

@export var camera : Camera2D;

var on_main := true;

@export var main_screen : Node;
@export var black_hole_screen : Node;

var contact := false;
var current_screen : Node;

var target_pos : Vector2;
var finished := true;

var offset := Vector2(576, 324);
var time := 0.0;

@export var drag_manager : Node;
@export var item_container : Control;
@export var spawn_container : Control;

@export var left_arrow : TextureRect;
@export var right_arrow : TextureRect;

func move_camera() -> void:
	if (!contact):
		var background = current_screen.find_child("Background");
		target_pos = background.position;
		finished = false;

func _ready() -> void:
	current_screen = main_screen;
	
func _process(delta: float) -> void:
	if (!finished):
		time += delta/2;
		var new_pos = lerp(camera.position, (target_pos + offset), time);
		camera.position = new_pos;
		
		if (current_screen == black_hole_screen):
			on_main = false;
			left_arrow.visible = false;
			if (drag_manager.current_held_object != null):
				drag_manager.current_held_object.in_black_hole = true;
				drag_manager.current_held_object.reparent(item_container);
			if (camera.position.x >= (target_pos + offset).x):
				camera.position = (target_pos + offset);
				current_screen = null;
				finished = true;
				time = 0.0;
				
				right_arrow.visible = true;
		else:
			right_arrow.visible = false;
			on_main = true;
			if (drag_manager.current_held_object != null):
				drag_manager.current_held_object.in_black_hole = false;
				drag_manager.current_held_object.reparent(spawn_container);
			if (camera.position.x <= (target_pos + offset).x):
				camera.position = (target_pos + offset);
				current_screen = null;
				left_arrow.visible = true;
				finished = true;
				time = 0.0;
	
func _on_left_collider_mouse_entered() -> void:
	if (current_screen != main_screen && finished):
		current_screen = main_screen;
	
	if (finished):
		move_camera();
	
	contact = true;

func _on_right_collider_mouse_entered() -> void:
	if (current_screen != black_hole_screen && finished):
		current_screen = black_hole_screen;
	
	if (finished):
		move_camera();
	
	contact = true;
	
func _on_right_collider_mouse_exited() -> void:
	contact = false;

func _on_left_collider_mouse_exited() -> void:
	contact = false;
