class_name Keyboard extends Node2D
@onready var _5_th_row_keys: Node2D = $"5thRowKeys"
@onready var _4_th_row_keys: Node2D = $"4thRowKeys"
@onready var _3_rd_row_keys: Node2D = $"3rdRowKeys"
@onready var _2_nd_row_keys: Node2D = $"2ndRowKeys"
@onready var _1_st_row_keys: Node2D = $"1stRowKeys"
@onready var hand_left: Sprite2D = $HandLeft
@onready var timer: Timer = $Timer


@onready var key_rows : Array[Node2D] = [_5_th_row_keys, _4_th_row_keys, _3_rd_row_keys, _2_nd_row_keys, _1_st_row_keys]



func _ready() -> void:
	SignalBus.key_pressed.connect(find_key_position)
	SignalBus.key_released.connect(lower_key)

func find_key_position(key_name : String) -> void:
	for row : Node2D in key_rows:
		for child : Sprite2D in row.get_children():
			if child.get_child_count() != 0 and child.name == StringName(key_name):
				child.position.y += 10
				hand_left.position = child.get_child(0).position
				timer.start()
		

func lower_key(key_name : String) -> void:
	for row : Node2D in key_rows:
		for child : Sprite2D in row.get_children():
			if child.get_child_count() != 0 and child.name == StringName(key_name):
				child.position.y -= 10



func _on_timer_timeout() -> void:
	pass # Replace with function body.
