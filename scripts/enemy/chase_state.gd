extends EnemyState

func _init() -> void:
	pass

func enter() -> void:
	#print("enter chase state")
	enemy.character_sprite.play("walk")

func exit() -> void:
	#print("exit chase state")
	pass

func update() -> void:
	pass

func physics_update() -> void:
	enemy.character_sprite.play("walk")

	if enemy.is_player_detected == false || enemy.detected_player == null:
		state_machine.change_state("IDLE")
		return

	enemy.debug_label.text = (
		"DONE :%s \n HIT TARGET :%s \n TARGET_REACHABLE: %s\n"
		% [
			enemy.nav2d.is_navigation_finished(),
			enemy.nav2d.is_target_reached(),
			enemy.nav2d.is_target_reachable()
		]
	)

	if enemy.nav2d.is_navigation_finished():
		return

	# next path and direction
	var next_path: Vector2 = enemy.nav2d.get_next_path_position()
	var direction = enemy.global_position.direction_to(next_path)

	enemy.velocity = direction * enemy.speed

	#flip the enemy-sprite acc. to the direction facing the player
	enemy.character_sprite.flip_h = (
		enemy.detected_player.global_position.x < enemy.global_position.x
	)

	# calculate distance between player and enemy
	var distance = (enemy.detected_player.global_position - enemy.global_position).length()

	if distance <= enemy.attack_range:
		state_machine.change_state("ATTACK")
		return

	enemy.move_and_slide()
