extends Node

@export var spawn_location : Control;
@export var spawn_object : PackedScene;

@export var fish_img : Texture2D;
@export var daisy_img : Texture2D;
@export var frog_img : Texture2D;
@export var cookie_img : Texture2D;

var max_num_objects := 4;
var num_objects := 0;

@export var delay_timer : Timer;
var delay_range := [1.0, 5.0];

var spawn_options := {
	"FISH": {"SIZE": Vector2(120.0, 80.0)},
	"COOKIE": {"SIZE": Vector2(80.0, 80.0)},
	"DAISY": {"SIZE": Vector2(80.0, 80.0)},
	"FROG": {"SIZE": Vector2(88.0, 80.0)}
}

func create_new_object() -> void:
	var new_object = spawn_object.instantiate();
	
	spawn_location.add_child(new_object);
	
	new_object.position = Vector2(randf_range(0.0, spawn_location.size.x), randf_range(0.0, spawn_location.size.y));
	
	var spawn_option = spawn_options.keys().pick_random();
	var spawn_option_value = spawn_options[spawn_option];
	
	new_object.size = spawn_option_value["SIZE"];
	
	match (spawn_option):
		"FISH":
			new_object.texture = fish_img;
		"FROG":
			new_object.texture = frog_img;
		"COOKIE":
			new_object.texture = cookie_img;
		"DAISY":
			new_object.texture = daisy_img;

	num_objects += 1;
	
func _process(_delta: float) -> void:
	if (delay_timer.is_stopped() && num_objects < max_num_objects):
		delay_timer.wait_time = randf_range(delay_range[0], delay_range[1]);
		delay_timer.start();
		
		create_new_object();
