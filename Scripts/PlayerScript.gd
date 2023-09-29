extends CharacterBody2D


var enemyAttackRange = false
var attackCooldown = true
var health = 100 
var playerAlive = true;

var attacking = false
const speed = 100

var current_direction = "none"

func ready():
	$AnimatedSprite2D.play("Front Idle")



func _physics_process(delta):
	player_movement(delta)
	enemyAttack()
	playerAttack()
	
	if health <= 0:
		playerAlive = false
		health = 0
		print("player dead")
		self.queue_free()
	
	
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
			if attacking == false:
				anim.play("Side Idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Side Walk")
		elif movement == 0:
			if attacking == false:
				anim.play("Side Idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("Back Walk")
		elif movement == 0:
			if attacking == false:
				anim.play("Back Idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("Front Walk")
		elif movement == 0:
			if attacking == false:
				anim.play("Front Idle")
	

func _on_hitbox_body_entered(body):
	if body.has_method("Enemy"):
		enemyAttackRange = true


func _on_hitbox_body_exited(body):
	if body.has_method("Enemy"):
		enemyAttackRange = false
		
		
func enemyAttack():
	if enemyAttackRange and attackCooldown == true:
		health = health - 20
		attackCooldown = false
		$HurtboxCooldown.start()
		print(health)
	
func player():
	pass

func _on_hurtbox_cooldown_timeout():
	attackCooldown = true

func playerAttack():
	var dir = current_direction
	
	if Input.is_action_just_pressed("Attack"):
		Global.player_current_attack = true
		attacking = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Side Attack")
			$AttackTimer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("Side Attack")
			$AttackTimer.start()
		if dir == "down":
			$AnimatedSprite2D.play("Front Attack")
			$AttackTimer.start()
		if dir == "up":
			$AnimatedSprite2D.play("Back Attack")
			$AttackTimer.start()
		

func _on_attack_timer_timeout():
	$AttackTimer.stop()
	Global.player_current_attack = false
	attacking = false
