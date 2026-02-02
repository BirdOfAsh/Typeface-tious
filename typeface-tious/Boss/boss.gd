class_name Boss extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var starting_location: Marker2D = $StartingLocation
@onready var ending_location: Marker2D = $EndingLocation
@onready var text: Sprite2D = $TEXT
@onready var animation_player: AnimationPlayer = $TEXT/AnimationPlayer


func _ready() -> void:
	SignalBus.call_da_boss.connect(tween_in)


func tween_in() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "position", ending_location.position, 1)
	await tween.finished
	animation_player.play("YAP")
	await animation_player.animation_finished
	SignalBus.missed_key.emit()
	tween_out()


func tween_out() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "position", starting_location.position, 1)
