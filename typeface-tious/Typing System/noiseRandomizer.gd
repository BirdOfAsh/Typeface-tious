extends AudioStreamPlayer

func play_random_pitch():
	# Randomize pitch between 0.8 and 1.2
	self.pitch_scale = randf_range(0.9, 1.1)
	self.play()
