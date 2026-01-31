class_name TypingSystem extends Node2D

@onready var text: RichTextLabel = $Text

var array_of_text : Array[String] = [
	"var variable : String = 'This is a variable'",
	"func _ready() -> void:",
	"print('My coworkers drive me crazy')"
	]

var listed_text : String = "This is a test sentence"
var typed_text : String = ""


func _ready() -> void:
	update_text(listed_text)
	check_against_text()


func _input(event: InputEvent) -> void:
	if !(event is InputEventKey) or !event.is_pressed() or event.is_echo():
		return
		
	var character : String = OS.get_keycode_string(event.get_key_label_with_modifiers())
	
	if character.length() == 1:
		add_key_to_string(character)
		
	elif character == "Backspace":
		remove_last_letter()
		
	elif character == "Space":
		add_key_to_string(" ")
	
	elif character == "Apostrophe":
		add_key_to_string("'")
	
	elif character == "Equal":
		add_key_to_string("=")
	
	elif character == "Minus":
		add_key_to_string("-")
	
	elif character.contains("Shift+"):
		character = character.replace("Shift+", "")
		
		match character:
			"3":
				add_key_to_string("#")
			"9":
				add_key_to_string("(")
			"0":
				add_key_to_string(")")
			"Semicolon":
				add_key_to_string(":")
			"Minus":
				add_key_to_string("_")
			"Period":
				add_key_to_string(">")
			character when character.length() == 1:
				add_capital_letter_to_string(character)
			_:
				add_key_to_string("?")

	
	check_against_text()
	#add_underline_to_next_letter()


func add_key_to_string(key : String) -> void:
	if typed_text.length() == listed_text.length():
		return
	
	typed_text = (typed_text + key.to_lower())


func add_capital_letter_to_string(key : String) -> void:
	if typed_text.length() == listed_text.length():
		return
	
	typed_text = typed_text + key


func remove_last_letter() -> void:
	if typed_text.is_empty():
		return
	
	typed_text = typed_text.substr(0, typed_text.length()-1)


func check_against_text() -> void:
	text.text = ""
	for i in range(typed_text.length()):
		if listed_text[i] == typed_text[i]:
			text.text += "[color=green]" + listed_text[i] + "[/color]"
		else:
			if listed_text[i] == " ":
				text.text += "[color=red]" + "_" + "[/color]"
			else:
				text.text += "[color=red]" + listed_text[i] + "[/color]"
		if i + 1 > typed_text.length() and typed_text.length() + 1 <= listed_text.length():
			text.text += "[u]" + listed_text[i + 1] + "[/u]"
	
	if !(typed_text.length() + 1 > listed_text.length()):
		add_underline_to_next_letter()
		text.text += listed_text.substr(typed_text.length() + 1, listed_text.length())
	
	
	if check_for_finished_text() == true:
		reset_text_line()


func check_for_finished_text() -> bool:
	if listed_text == typed_text:
		return true
	
	return false


func reset_text_line() -> void:
	var rand_int : int = randi_range(0, array_of_text.size() - 1)
	listed_text = array_of_text[rand_int]
	typed_text = ""
	update_text(listed_text)


func update_text(updated_text : String) -> void:
	text.text = updated_text


func add_underline_to_next_letter() -> void:
	if typed_text.length() < listed_text.length():
		text.text += "[u]"+listed_text[+typed_text.length()]+"[/u]"
