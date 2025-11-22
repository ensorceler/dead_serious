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
	
	enemy.debug_label.text= "DONE :%s \n HIT TARGET :%s \n TARGET_REACHABLE: %s\n" % [
		enemy.nav2d.is_navigation_finished(), 
		enemy.nav2d.is_target_reached(),
		enemy.nav2d.is_target_reachable()
	]
	
	if enemy.nav2d.is_navigation_finished():
		return 
		
	# next path and direction 
	var next_path:Vector2=enemy.nav2d.get_next_path_position() 
	var direction=enemy.global_position.direction_to(next_path)
	
	
	enemy.velocity= direction * enemy.SPEED
	
	if enemy.detected_player.position.x<enemy.position.x:
		enemy.character_sprite.flip_h=true
	else: 
		enemy.character_sprite.flip_h=false
		
	# calculate distance between player and enemy
	var distance=(enemy.detected_player.global_position-enemy.global_position).length()
	print("distance from player",distance)
	
	
	if distance<=enemy.ATTACK_RANGE:
		state_machine.change_state("ATTACK")
		return
	
	enemy.move_and_slide()
	
	
