extends CharacterBody2D

var speed = 30
var chasestate = null 
var player = null

var health = 100
var playerInAttackZone = false
var HurtboxActive = true

var enemyInstance = preload("res://Levels/enemy.tscn")

func InstantiateEnemy(pos):
	var instance = enemyInstance.instantiate()

	instance.position = pos
	add_child(instance)

func _physics_process(delta):
	takedamage()
	
	if chasestate == true:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("Walk")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true;
		else:
			$AnimatedSprite2D.flip_h = false;
			
	else:
		$AnimatedSprite2D.play("Idle")


func _on_detection_area_body_entered(body):
	player = body
	chasestate = true

func _on_detection_area_body_exited(body):
	player = null
	chasestate = false
	

func Enemy():
	pass
	



func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInAttackZone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInAttackZone = false

func takedamage():
	if playerInAttackZone and Global.player_current_attack == true:
		if HurtboxActive == true:
			health = health - 20
			$HurtboxCooldown.start()
			HurtboxActive = false
			print("slime health = ", health)
			if health <=0:
				self.queue_free()
				health = 100
				InstantiateEnemy(Vector2(250,150))
		


func _on_hurtbox_cooldown_timeout():
	HurtboxActive = true
