extends CharacterBody2D

var speed = 30
var chasestate = null 
var player = null

func _physics_process(delta):
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
	






