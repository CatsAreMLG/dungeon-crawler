extends Node2D

var TYPE = null
const DAMAGE = 1

var maxamount = 1

func _ready():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing",get_parent().attack_dir))
#	get_node("Sprite").z_index=get_node("../../../TileMap").z_index-1
	z_as_relative=true
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"

func destroy(animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	queue_free()