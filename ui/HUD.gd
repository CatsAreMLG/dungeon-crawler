extends CanvasLayer

var player

func _ready():
	player = get_parent().get_node("./YSort/player")
	for x in range(player.health):
		x+=1
		var heart = preload("res://ui/hearts.tscn")
		var newheart= heart.instance()
		if x%2==0:
			newheart.add_to_group(str(heart,self))
			add_child(newheart)
			newheart.position += Vector2(8*x-8,8)
		elif x == player.health:
			newheart.add_to_group(str(heart,self))
			add_child(newheart)
			newheart.position += Vector2(8*x,8)
			newheart.get_node("heart").frame=1
	#		newheart.queue_free()