extends EnemyState 


func _init() -> void: 
	pass
	
func enter() -> void:
	print("enter chase state")
	enemy.character_sprite.play("walk")
	
	
func exit() -> void:
	print("exit chase state")


func update() -> void:
	pass
	
func physics_update() -> void:
	enemy.character_sprite.play("walk")
	
	if enemy.is_player_detected==false || enemy.detected_player==null:
		state_machine.change_state("IDLE")
		return
	
	var distance=(enemy.position-enemy.detected_player.position).length()
	
	var direction=(enemy.detected_player.position-enemy.position).normalized()
	
	if enemy.detected_player.position.x<enemy.position.x:
		enemy.character_sprite.flip_h=true
	else: 
		enemy.character_sprite.flip_h=false
		
	
	if distance<=enemy.ATTACK_RANGE:
		state_machine.change_state("ATTACK")
		return
	
	enemy.velocity = direction * enemy.SPEED;
	
	enemy.move_and_slide()
	
	
	
