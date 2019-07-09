extends AnimationPlayer

var timer = 30

func _ready():
	play('lava')

func _process(delta):
	if timer <= 0:
		playback_speed = randf() * 3 + 2
		timer = 15
	timer -= 1