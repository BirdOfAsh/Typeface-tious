class_name Woman extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var staring_pos: Marker2D = $Sprite2D/StaringPos
@onready var ending_pos: Marker2D = $Sprite2D/EndingPos
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var ausd: Sprite2D = $Sprite2D/AUSD



func tween_in() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "position", ending_pos.position, 1)
	await tween.finished
	animation_player.play("YAPPER")
	ausd.visible = true
	await get_tree().create_timer(3).timeout
	tween_out()


func tween_out() -> void:
	ausd.visible = false
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "position", staring_pos.position, 1)
	await tween.finished
	timer.start()


func _on_timer_timeout() -> void:
	tween_in()
