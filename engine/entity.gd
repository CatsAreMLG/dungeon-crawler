class_name entity
extends KinematicBody2D

var SPEED = 0
var TYPE = "ENEMY"
var MAXHEALTH = 2
var DAMAGE = 1

var movedir = dir.center
var knockdir = dir.center
var spritedir = "right"

var health = MAXHEALTH
var hitstun = 0
var hurt = 0
var texture_default = null
var texture_hurt = null

func _ready():
	if TYPE == "ENEMY":
		set_physics_process(false)

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
	move_and_slide(motion, dir.center)

func spritedir_loop():
	match movedir.x:
		dir.left.x:
			spritedir = "left"
		dir.right.x:
			spritedir = "right"

func anim_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	if hurt > 0:
		hurt -= 1
		$Sprite.modulate = Color(10,0.5,0.5,0.9)
	else:
		$Sprite.modulate = Color(1,1,1,1)
		if TYPE == "ENEMY" && health <= 0:
			var death_animation = preload("res://enemies/enemy_death.tscn").instance()
			get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			queue_free()
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 && body.get("DAMAGE") != 0 && body.get("TYPE") != TYPE && body.get_class() != "Camera2D":
			health -= body.get("DAMAGE")
			hitstun = 10
			hurt = 5
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(item,self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(),self)).size() > newitem.maxamount:
		newitem.queue_free()
