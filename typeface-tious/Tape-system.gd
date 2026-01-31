extends Node2D
signal Dead

const ICON = preload("uid://gccj7ch5hw4d")
const Pwhizz = preload("uid://7xp3jlwl20t3")
const Pwhizz2 = preload("uid://bt4py1a77veni")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var button: Button = $Button



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
	
