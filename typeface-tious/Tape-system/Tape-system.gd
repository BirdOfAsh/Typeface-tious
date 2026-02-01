extends Node2D
signal Dead

@export var tapeeeeeeeee_scene : PackedScene

const LIGHT_DAMAGE_MASK = preload("res://assets/light_damage/light_damage_mask.png")
const MID_DAMAGE_MASK = preload("res://assets/mid_damage/mid_damage_mask.png")

const FRESH_FACE = preload("uid://dygxtt5fbuvrg")
const MID_TAPE_1 = preload("uid://umvxo4c6fyyh")
const MID_TAPE_3 = preload("uid://bj2qnfadq31i6")

@onready var face_sprite: Sprite2D = $Facebox/FaceSprite
@onready var tape_box: Area2D = $TapeBox
@onready var face: Area2D = $Facebox
@onready var mid_tape_1: Sprite2D = $Facebox/FaceSprite/Mid_Tape_1
@onready var mid_tape_2: Sprite2D = $Facebox/FaceSprite/Mid_Tape_2
@onready var mid_tape_3: Sprite2D = $Facebox/FaceSprite/Mid_Tape_3
@onready var light_tape_1: Sprite2D = $Facebox/FaceSprite/Light_Tape_1
@onready var light_tape_2: Sprite2D = $Facebox/FaceSprite/Light_Tape_2

var dragging := false 
var tape:  Area2D
var tape_over_target = false 



func _ready() -> void:
	SignalBus.missed_key.connect(Damage)


func _process(_delta):
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
	if StateNum == 4:
		StateNum = 3
	elif StateNum == 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

func _on_button_pressed():
	Damage()
	

var StateNum : int = 3


func ChangeStates():
	if StateNum !=0 and StateNum < 4:
		if StateNum == 1:
			light_tape_1.show()
			light_tape_2.show()
			mid_tape_1.show()
			mid_tape_2.show()
			mid_tape_3.show()
			face_sprite.texture = MID_DAMAGE_MASK
		elif StateNum == 2:
			light_tape_1.show()
			light_tape_2.show()
			mid_tape_1.hide()
			mid_tape_2.hide()
			mid_tape_3.hide()
			face_sprite.texture = LIGHT_DAMAGE_MASK
		elif StateNum == 3:
			mid_tape_1.hide()
			mid_tape_2.hide()
			mid_tape_3.hide()
			light_tape_1.hide()
			light_tape_2.hide()
			face_sprite.texture = FRESH_FACE
		

	
func Damage():
	StateNum = clampi(StateNum - 1, 0 , 3)
	ChangeStates()
	
func Heal():
	StateNum = clampi(StateNum + 1, 0 , 3)
	ChangeStates() 
		
func _on_face_box_input_event(_viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				$AudioStreamPlayer.play()
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
