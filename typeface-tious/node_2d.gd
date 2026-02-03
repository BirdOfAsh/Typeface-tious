class_name Clock extends Node2D
@onready var hours_hand: Line2D = $Sprite2D/Hours
@onready var minutes_hand: Line2D = $Sprite2D/Minutes

signal clock_finished

var time : float = 9.0
var hours : int = 1
var minutes : float = 0.0

func _ready() -> void:
	SignalBus.line_finished.connect(add_hour)



func add_hour() -> void:
	hours += 1
	hours_hand.rotate(deg_to_rad(30))
	check_for_win()


func check_for_win() -> void:
	if hours == 8:
		clock_finished.emit()
