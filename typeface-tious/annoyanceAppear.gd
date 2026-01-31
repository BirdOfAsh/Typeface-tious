extends Node2D

func _ready() -> void:
	coordinatesOffScreen = position

var speed : float = 40.0
var onScreen : bool = true
var coordinatesOffScreen: Vector2 = position
var coordinatesOnScreen : Vector2 = Vector2(100, 250)

func _physics_process(_delta: float) -> void:
	if onScreen == true:
		position = position.move_toward(coordinatesOnScreen, speed)
	else:
		position = position.move_toward(coordinatesOffScreen, speed)
		
	if position == coordinatesOffScreen:
		hide()
	else:
		show()



#this entire part should be removed once there is an actual trigger
var elapsedTime : float
var elapsedTimeInSecs : int
var lastValue : int
func _process(delta: float) -> void:
	elapsedTime += delta 
	elapsedTimeInSecs = int(elapsedTime) #this might be weird with rounding, but it works so here we are
	
	if elapsedTimeInSecs % 5 == 0 and elapsedTimeInSecs != lastValue:
		lastValue = elapsedTimeInSecs
		onScreen = !onScreen
