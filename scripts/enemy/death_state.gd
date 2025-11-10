extends EnemyState 


func _init() -> void: 
	pass
	
func enter() -> void:
	enemy.character_sprite.play("dead")
	await enemy.character_sprite.animation_finished  # ← Wait for animation to end!
	queue_free() 
	
	print("enter death state")
	
func exit() -> void:
	print("exit death state")


func update() -> void:
	pass
	
func physics_update() -> void:
	pass 
	
	
	
