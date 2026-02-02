class_name Game extends Node
@onready var clock: Node2D = $clock
@onready var typing_system : TypingSystem = %"Typing System"

func _ready() -> void:
	#typing_system.day_finished.connect(day_won)
	clock.clock_finished.connect(day_won)

func day_won() -> void:
	SignalBus.switch_scene.emit(self)
