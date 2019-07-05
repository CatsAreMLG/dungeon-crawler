extends entity

var state = "default"
var attack_dir = "right"

func _init():
	SPEED = 70
	TYPE = "PLAYER"
	DAMAGE = 0

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()

func check_attack():
	if Input.is_action_just_pressed("ui_up"):
		return 1
	if Input.is_action_just_pressed("ui_down"):
		return 2
	if Input.is_action_just_pressed("ui_right"):
		return 3
	if Input.is_action_just_pressed("ui_left"):
		return 4

func state_default():
	controls_loop()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	if movedir != dir.center:
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	match check_attack():
		1:
			attack_dir = "up"
			use_item(preload("res://items/sword.tscn"))
		2:
			attack_dir = "down"
			use_item(preload("res://items/sword.tscn"))
		3:
			attack_dir = "right"
			spritedir = "right"
			use_item(preload("res://items/sword.tscn"))
		4:
			spritedir = "left"
			attack_dir = "left"
			use_item(preload("res://items/sword.tscn"))

func state_swing():
	anim_switch("idle")
	movement_loop()
	damage_loop()
	movedir = dir.center

func controls_loop():
	var UP    = Input.is_key_pressed(KEY_W)
	var LEFT  = Input.is_key_pressed(KEY_A)
	var DOWN  = Input.is_key_pressed(KEY_S)
	var RIGHT = Input.is_key_pressed(KEY_D)
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
