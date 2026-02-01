extends Node2D
signal Dead

@export var tapeeeeeeeee_scene : PackedScene


const ICON = preload("uid://gccj7ch5hw4d")
const Pwhizz = preload("uid://7xp3jlwl20t3")
const Pwhizz2 = preload("uid://bt4py1a77veni")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var tape_box: Area2D = $TapeBox
var dragging := false 
var tape:  Area2D
var tape_over_target = false 
@onready var face: Area2D = $Facebox




func _process(delta):
	if tape and dragging:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			tape.global_position = get_global_mouse_position()
		# Detect mouse release
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			dragging = false
			if tape_over_target:
				Heal()
				print("Char healed!")
			if tape:
				tape.queue_free()
				tape = null
				tape_over_target = false

func _on_button_pressed():
	Heal()
	

var StateNum : int = 1


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
		else:
			if tape:
				tape.queue_free()
				tape = null
				tape_over_target = false
	
func _on_facebox_area_entered(area: Area2D) -> void:
	if area == tape:
		tape_over_target = true 
		print ("im taped up")
	
func _on_facebox_area_exited(area: Area2D) -> void:
	if area == tape:      # Check if it’s the tape exiting
		tape_over_target = false
		print("Tape left the face!") 
