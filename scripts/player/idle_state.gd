extends PlayerState

class_name IdleState 



func _init():
	#print("idle state init")
	pass 


func enter():
	#print("entering idle state")
	#print("parent ",get_parent())
	if player.ready: 
		player.animated_sprite.play("idle")
		player.velocity = Vector2.ZERO

	
	
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
		
