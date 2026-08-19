extends TextureRect

@export var particles : CPUParticles2D;

@onready var tree = get_tree();

var drag_manager : Node;
var in_black_hole := false;
var hovered_over := false;

var initial_distance_x := 0.0;
var initial_distance_y := 0.0;
var moving_in := false;

var final_home : Control;

func _ready() -> void:
	drag_manager = tree.root.find_child("DragManager", true, false);
	final_home = tree.root.find_child("Final", true, false);
	
func _input(event: InputEvent) -> void:
	if (hovered_over && event is InputEventMouseButton && event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT && !in_black_hole):
		if (drag_manager.current_held_object == null):
			drag_manager.current_held_object = self;
			
	if (event is InputEventMouseButton && event.is_released() && in_black_hole):
		var temp_pos = global_position;
		self.reparent(final_home);
		global_position = temp_pos;
		
		particles.visible = true;
		
	if (event is InputEventMouseButton && event.is_released() && event.button_index == MOUSE_BUTTON_LEFT):
		if (drag_manager.current_held_object == self):
			drag_manager.current_held_object = null;
		
func _on_mouse_entered() -> void:
	hovered_over = true;

func _on_mouse_exited() -> void:
	hovered_over = false;
