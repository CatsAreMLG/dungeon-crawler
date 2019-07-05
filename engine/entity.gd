class_name entity
extends KinematicBody2D

var SPEED = 0
var TYPE = "ENEMY"
var DAMAGE = 1

var movedir = dir.center
var knockdir = dir.center
var spritedir = "right"

var hitstun = 0
var health = 1

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
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 && body.get("DAMAGE") != 0 && body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(item,self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(),self)).size() > newitem.maxamount:
		newitem.queue_free()