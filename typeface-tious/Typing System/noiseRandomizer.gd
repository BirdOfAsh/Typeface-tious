class_name KeyboardAudio extends AudioStreamPlayer

func play_random_pitch():
	# Randomize pitch between 0.8 and 1.2
	self.pitch_scale = randf_range(2, 3)
	self.play(0.03)
