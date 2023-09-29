extends Timer

var enemyInstance = preload("res://Levels/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	randomize()
	var enemy = enemyInstance.instantiate()
	enemy.position = Vector2(randf_range(150,250),randf_range(100,150))
	add_child(enemy)
	wait_time = randf_range(0,5)
	
	
