extends PlayerState


class_name WalkState 


func _init() -> void: 
	pass
	
	

func enter() -> void:
	#print("entering walk state")
	
	if player.ready: 
		player.animated_sprite.play("run")
	
	
func exit() -> void: 
	#print("exiting the walk state")
	pass
	
func update(delta: float) -> void:
	pass 
	
func physics_update(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		direction.x-=1
		player.face_direction="left"
		player.animated_sprite.flip_h=true
		player.animated_sprite.play("run")
	if Input.is_action_pressed("move_right"):
		direction.x+=1
		player.face_direction="right"
		player.animated_sprite.flip_h=false
		player.animated_sprite.play("run")
	if Input.is_action_pressed("move_down"):
		direction.y+=1
		player.animated_sprite.play("run")
	if Input.is_action_pressed("move_up"):
		direction.y-=1
		player.animated_sprite.play("run")
	
	if player.face_direction=="left":
		player.animated_sprite.flip_h=true 
	else:
		player.animated_sprite.flip_h=false
		
	if direction.length()>0:
		direction = direction.normalized()
		player.velocity = direction * player.speed
		player.move_and_slide()
	elif direction.length()==0:
		state_machine.change_state("idle")
		return
	
	
	
func handle_input(event: InputEvent) -> void:
	pass
	
