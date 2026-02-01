class_name GameStateManager extends Node

var main_game : PackedScene = preload("res://Game Scene/game.tscn")
var credits : PackedScene

func _ready() -> void:
	SignalBus.switch_scene.connect(switch_scenes)


func switch_scenes(current_scene : Node) -> void:
	var new_scene : PackedScene
	var loaded_scene : Node
	match String(current_scene.name):
		"MainMenu":
			current_scene.queue_free()
			new_scene = main_game
			loaded_scene = new_scene.instantiate()
		"Game":
			current_scene.queue_free()
			new_scene = main_game
			loaded_scene = new_scene.instantiate()
	
	
	add_child(loaded_scene)
