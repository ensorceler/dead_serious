class_name CharacterWalkState 
extends CharacterState 



func _init() -> void: 
	pass 

func enter() -> void:
	if character.ready: 
		character.play_animation("walk")
	
func exit() -> void: 
	pass

func update(delta: float) -> void:
	pass 
	
func physics_update(delta: float) -> void:
	var direction = Vector2.ZERO
	character.play_animation("walk")
	
	if Input.is_action_pressed("move_left"):
		direction.x-=1
		character.face_direction="left"
	if Input.is_action_pressed("move_right"):
		direction.x+=1
		character.face_direction="right"
	if Input.is_action_pressed("move_down"):
		direction.y+=1
	if Input.is_action_pressed("move_up"):
		direction.y-=1
		
	
	# flip the character acc to direction
	character.flip_character()
	
	if direction.length()>0:
		direction = direction.normalized()
		character.velocity = direction * character.speed
		character.move_and_slide()
		# emit character position each time
		#GlobalSignals.character_position_changed.emit(character.position)
	
	elif direction.length()==0:
		state_machine.change_state("idle")
		return

func handle_input(event: InputEvent) -> void:
	pass
	
