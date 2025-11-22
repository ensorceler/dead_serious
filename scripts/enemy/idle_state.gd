extends EnemyState 



func _init() -> void: 
	pass
	
func enter() -> void:
	#print("enter idle state")
	enemy.character_sprite.play("idle")
	enemy.velocity = Vector2.ZERO

func exit() -> void:
	#print("exit idle state")
	pass

func update() -> void:
	pass
	
func physics_update() -> void:
	# keep playing idle-animation
	enemy.character_sprite.play("idle")
	
	if enemy.is_player_detected: 
		# transitiion to chase
		state_machine.change_state("CHASE")
		return

	
	
	
