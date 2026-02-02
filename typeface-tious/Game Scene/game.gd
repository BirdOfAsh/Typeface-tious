class_name Game extends Node
@onready var clock: Node2D = $clock
@onready var face: Node2D = $Face


func _ready() -> void:
	clock.clock_finished.connect(day_won)
	face.Dead.connect(DIE)


func day_won() -> void:
	SignalBus.switch_scene.emit(self)

func DIE():
	SignalBus.switch_scene.emit(self, true)
