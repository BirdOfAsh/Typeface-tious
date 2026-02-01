extends Node2D

func _ready() -> void:
	marker = $Marker2D
	sprite = $Sprite2D
	textBubble = $SpriteTextBubble
	coordinatesOnScreen = marker.position
	coordinatesOffScreen = sprite.position

var speed : float = 5.0
var onScreen : bool = false
var atLocation : bool = false #different from onScreen variable because onScreen is true while the sprite is moving
var coordinatesOffScreen: Vector2
var coordinatesOnScreen : Vector2
var marker : Marker2D
var sprite : Sprite2D
var textBubble : Sprite2D
var lifeTimer : float

func _physics_process(_delta: float) -> void:
	
	if onScreen == true:
		lifeTimer = 9.0
		sprite.position = sprite.position.move_toward(coordinatesOnScreen, speed)
	else:
		sprite.position = sprite.position.move_toward(coordinatesOffScreen, speed)
	
	
	if sprite.position == coordinatesOnScreen:
		atLocation = true
	elif sprite.position == coordinatesOffScreen:
		#at starting location offscreen
		hide()
	else:
		atLocation = false
		show()
	
	
	if atLocation == true:
		textBubble.show()
	else:
		textBubble.hide()
