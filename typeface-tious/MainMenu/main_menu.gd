extends Node


func _on_start_pressed() -> void:
	SignalBus.switch_scene.emit(self)
	pass # Replace with function body.


func _on_credit_pressed() -> void:
	pass # Replace with function body.
