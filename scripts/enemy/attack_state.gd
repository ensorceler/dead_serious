extends EnemyState 


func _init() -> void: 
	pass
	
func enter() -> void:
	print("enter attack state")
	enemy.velocity=Vector2.ZERO
	enemy.character_sprite.play("attack")
	
func exit() -> void:
	print("exit attack state")


func update() -> void:
	pass
	
func physics_update() -> void:
	enemy.character_sprite.play("attack")
	enemy.character_sprite.flip_h = enemy.detected_player.position.x < enemy.position.x

	
	if enemy.detected_player==null:
		state_machine.change_state("IDLE")
		return
		
	var distance=(enemy.position-enemy.detected_player.position).length()
	var direction=(enemy.detected_player.position - enemy.position).normalized()
	
		
	
	if distance>enemy.ATTACK_RANGE:
		state_machine.change_state("CHASE")
		return
		
	
