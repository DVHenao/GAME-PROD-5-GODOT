extends CharacterBody2D

const speed = 100

var current_direction = "none"

func ready():
	$AnimatedSprite2D.play("Front Idle")



func _physics_process(delta):
	player_movement(delta)
	
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()


func play_anim(movement):
	var dir = current_direction
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Side Walk")
		elif movement == 0:
			anim.play("Side Idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Side Walk")
		elif movement == 0:
			anim.play("Side Idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("Back Walk")
		elif movement == 0:
			anim.play("Back Idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("Front Walk")
		elif movement == 0:
			anim.play("Front Idle")
	
