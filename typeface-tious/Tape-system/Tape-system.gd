extends Node2D
signal Dead

@export var tapeeeeeeeee_scene : PackedScene


const LIGHT_DAMAGE_MASK = preload("res://assets/light_damage/light_damage_mask.png")
const MID_DAMAGE_MASK = preload("res://assets/mid_damage/mid_damage_mask.png")

const FRESH_FACE = preload("uid://dygxtt5fbuvrg")

@onready var face_sprite: Sprite2D = $Facebox/FaceSprite
@onready var tape_box: Area2D = $TapeBox
var dragging := false 
var tape:  Area2D
var tape_over_target = false 
@onready var face: Area2D = $Facebox



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

func _on_button_pressed():
	Heal()
	

var StateNum : int = 3


func ChangeStates():
	if StateNum !=0 and StateNum <= 3:
		if StateNum == 1:
			face_sprite.texture = MID_DAMAGE_MASK
		elif StateNum == 2:
			face_sprite.texture = LIGHT_DAMAGE_MASK
		elif StateNum == 3:
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
