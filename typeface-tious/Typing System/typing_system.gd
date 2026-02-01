class_name TypingSystem extends Node2D

@onready var text_1: RichTextLabel = $Text
@onready var text_2: RichTextLabel = $Text2
@onready var text_3: RichTextLabel = $Text3

@onready var array_of_text_lines : Array[RichTextLabel] = [text_1, text_2, text_3]

var current_text_line : RichTextLabel

var array_of_text_options : Array[String] = [
	"var variable : String = 'This is a variable'",
	"func _ready() -> void:",
	"print('My coworkers drive me crazy')"
	]

var listed_text : String = "This is a test sentence"
var typed_text : String = ""


func _ready() -> void:
	reset_text_lines()
	current_text_line = array_of_text_lines[0]
	check_against_text()


func _input(event: InputEvent) -> void:
	if !(event is InputEventKey) or !(event.is_pressed() or event.is_released()) or event.is_echo():
		return
	
	
	var character : String = OS.get_keycode_string(event.get_key_label_with_modifiers())
	
	if event.is_released():
		if character.contains("Shift+"):
			SignalBus.key_released.emit(character.replace("Shift+", ""))
		else:
			SignalBus.key_released.emit(character)
		return
	
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
	
	
	SignalBus.key_pressed.emit(character)
	check_against_text()


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
	current_text_line.text = ""
	for i in range(typed_text.length()):
		if listed_text[i] == typed_text[i]:
			current_text_line.text += "[color=green]" + listed_text[i] + "[/color]"
		else:
			if listed_text[i] == " ":
				current_text_line.text += "[color=red]" + "_" + "[/color]"
			else:
				current_text_line.text += "[color=red]" + listed_text[i] + "[/color]"
				
		if i + 1 > typed_text.length() and typed_text.length() + 1 <= listed_text.length():
			current_text_line.text += "[u]" + listed_text[i + 1] + "[/u]"
	
	if !(typed_text.length() + 1 > listed_text.length()):
		add_underline_to_next_letter()
		current_text_line.text += listed_text.substr(typed_text.length() + 1, listed_text.length())
	
	
	if check_for_finished_text() == true:
		move_to_next_line()


func check_for_finished_text() -> bool:
	if listed_text == typed_text:
		return true
	
	return false


func reset_text_lines() -> void:
	for line in array_of_text_lines:
		var rand_int : int = randi_range(0, array_of_text_options.size() - 1)
		listed_text = array_of_text_options[rand_int]
		update_text(line, listed_text)


func move_to_next_line() -> void:
	if current_text_line == array_of_text_lines[-1]:
		reset_text_lines()
		current_text_line = array_of_text_lines[0]
		update_day_progress()
	else:
		current_text_line = array_of_text_lines[array_of_text_lines.find(current_text_line) + 1]
	
	typed_text = ""
	listed_text = current_text_line.text
	check_against_text()


func update_text(line : RichTextLabel, updated_text : String) -> void:
	line.text = updated_text


func add_underline_to_next_letter() -> void:
	if typed_text.length() < listed_text.length():
		current_text_line.text += "[u]"+listed_text[+typed_text.length()]+"[/u]"


func update_day_progress() -> void:
	SignalBus.line_finished.emit()
