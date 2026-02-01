class_name Game extends Node
@onready var clock: Node2D = $clock


func _ready() -> void:
	clock.clock_finished.connect(day_won)


func day_won() -> void:
	SignalBus.switch_scene.emit(self)
