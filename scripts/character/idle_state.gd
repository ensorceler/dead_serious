class_name CharacterIdleState
extends CharacterState


func _init():
	#print("idle state init")
	pass 


func enter():
	#print("entering idle state")
	#print("parent ",get_parent())
	if character.ready: 
		character.play_animation("idle")
		character.velocity = Vector2.ZERO

	
	
func exit():
	pass
	

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	pass

		
	
func handle_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right") || Input.is_action_just_pressed("move_up") || Input.is_action_just_pressed("move_down"):
		state_machine.change_state("walk")
	pass
		
