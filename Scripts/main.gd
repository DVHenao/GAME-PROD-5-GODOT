extends Node


var enemyInstance = preload("res://Levels/enemy.tscn")

func InstantiateEnemy(pos):
	var instance = enemyInstance.instantiate()

	instance.position = pos
	add_child(instance)
