extends Node2D
signal Dead

@onready var face: Node2D = $"."
var StateNum : int = 0

func ChangeStates():
	if StateNum !=0 and StateNum > 4:
		
		pass

	
func Damage():
	StateNum = StateNum - 1
	
func Heal():
	StateNum = StateNum + 1 
	
