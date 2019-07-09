extends Camera2D

func _init():
	var DAMAGE = 0

func _ready():
	$area.connect("body_entered", self,"body_entered")
	$area.connect("body_exited", self,"body_exited")

func _process(delta):
	var pos = get_node("../YSort/player").global_position
	global_position = Vector2(pos.x,pos.y)

func body_entered(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(true)

func body_exited(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(false)