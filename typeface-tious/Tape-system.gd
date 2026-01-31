extends Node2D
signal Dead

@export var tapeeeeeeeee_scene : PackedScene


const ICON = preload("uid://gccj7ch5hw4d")
const Pwhizz = preload("uid://7xp3jlwl20t3")
const Pwhizz2 = preload("uid://bt4py1a77veni")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var button: Button = $Button
@onready var face: Node2D = $"."
@onready var face_box: Area2D = $FaceBox
var dragging := false 
var tape: Node2D



func _process(delta):
	if tape:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			tape.global_position = get_global_mouse_position()
		else:
			tape.queue_free()
			tape = null
	


func _on_button_pressed():
	Heal()
	

var StateNum : int = 0


func ChangeStates():
	if StateNum !=0 and StateNum <= 3:
		if StateNum == 1:
			sprite_2d.texture = ICON
		elif StateNum == 2:
			sprite_2d.texture = Pwhizz
		elif StateNum == 3:
			sprite_2d.texture = Pwhizz2
		

	
func Damage():
	StateNum = StateNum - 1
	ChangeStates()
	
func Heal():
	StateNum = StateNum + 1
	ChangeStates() 
		
func _on_face_box_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				tape = tapeeeeeeeee_scene.instantiate()
				get_tree().current_scene.add_child(tape)
				
				tape.global_position = get_global_mouse_position()
				dragging = true 
			if not event.pressed:
				tape.queue_free()
					
				pass
				
