extends Node2D

var time : float = 9.0
var hours : float
var minutes : float
var hoursHand : Line2D
var minutesHand : Line2D

func _ready() -> void:
	hoursHand = $Sprite2D/Hours
	minutesHand = $Sprite2D/Minutes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta / 60
	hours = time
	minutes = time * 60
	hoursHand.rotation = hours
	minutesHand.rotation = minutes
 	#get_tree().change_scene_to_file("res://win_scene.tscn")
