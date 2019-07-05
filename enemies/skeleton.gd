extends entity

var movetimer_length = 15
var movetimer = 0

func _init():
	TYPE = "ENEMY"
	SPEED = 40
	DAMAGE = 1

func _ready():
	$anim.play("idleright")
	movedir = dir.rand()

func _physics_process(delta):
	movement_loop()
	spritedir_loop()
	damage_loop()

	if movetimer > 0:
		movetimer -=1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length

	if movedir != dir.center:
		anim_switch("walk")
	else:
		anim_switch("idle")