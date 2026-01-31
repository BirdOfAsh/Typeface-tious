extends Node2D

var coordinatesOffScreen: Vector2 = position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coordinatesOffScreen = position

var minTime : int = 40
var maxTime : int = 60
var elapsedTime : float
var elapsedTimeInSecs : int
var speed : float = 40.0
var onScreen : bool = true
var coordinatesOnScreen : Vector2 = Vector2(100, 250)
var lastValue : int

func _process(delta: float) -> void:
	elapsedTime += delta 
	elapsedTimeInSecs = int(elapsedTime) #this might be weird with rounding, but it works so here we are,
	#probably should also be deleted and moved to a game manager

func _physics_process(_delta: float) -> void:
	if elapsedTimeInSecs % 5 == 0 and elapsedTimeInSecs != lastValue:
		lastValue = elapsedTimeInSecs
		onScreen = !onScreen

	if onScreen == true:
		position = position.move_toward(coordinatesOnScreen, speed)
	else:
		position = position.move_toward(coordinatesOffScreen, speed)
		
	if position == coordinatesOffScreen:
		hide()
	else:
		show()
