class_name GameStateManager extends Node

var main_game : PackedScene = preload("res://Game Scene/game.tscn")
var retry : PackedScene = preload("res://game_over.tscn")
var credits : PackedScene
var tutorial : PackedScene = preload("uid://b7ktl4y4dshbs")

func _ready() -> void:
	SignalBus.switch_scene.connect(switch_scenes)
	print(retry)


func switch_scenes(current_scene : Node, die : bool = false) -> void:
	var new_scene : PackedScene
	var loaded_scene : Node
	match String(current_scene.name):
		"MainMenu":
			current_scene.queue_free()
			new_scene = tutorial
			loaded_scene = new_scene.instantiate()
		"Game":
			current_scene.queue_free()
			if die:
				new_scene = retry
				loaded_scene = new_scene.instantiate()
			else:
				new_scene = main_game
				loaded_scene = new_scene.instantiate()
		"GameOver":
			current_scene.queue_free()
			new_scene = main_game
			loaded_scene = new_scene.instantiate()
		"Tutorial":
			current_scene.queue_free()
			new_scene = main_game
			loaded_scene = new_scene.instantiate()
			
			
	add_child(loaded_scene)
