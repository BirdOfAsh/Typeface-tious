extends Node2D
@onready var hours_hand: Line2D = $Sprite2D/Hours
@onready var minutes_hand: Line2D = $Sprite2D/Minutes

signal clock_finished

var time : float = 9.0
var hours : float = 0.0
var minutes : float = 0.0

func _ready() -> void:
	SignalBus.line_finished.connect(add_hour)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#time += delta / 60
	#hours = time
	#minutes = time * 60
	#hoursHand.rotation = hours
	#minutesHand.rotation = minutes
 	#get_tree().change_scene_to_file("res://win_scene.tscn")


func add_hour() -> void:
	hours += 1.0
	hours_hand.rotate(deg_to_rad(30))


func check_for_win() -> void:
	if hours == 8.0:
		clock_finished.emit()
