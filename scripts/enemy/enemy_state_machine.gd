extends Node 

class_name EnemyStateMachine 

@export var initial_state:EnemyState;
var current_state:EnemyState
var states:Dictionary[String, EnemyState]={}



func _ready() -> void:
	await owner.ready
	
	var enemy=get_parent()
	for child:EnemyState in get_children():
		if child is EnemyState: 
			states[child.name.to_lower()]=child
			child.state_machine=self
			child.enemy=enemy
		
	if initial_state && initial_state is EnemyState: 
		current_state=initial_state 
		current_state.enter()
		
		
	
func _process(delta: float) -> void:
	if current_state: 
		current_state.update() 
	

func _physics_process(delta: float) -> void:
	if current_state: 
		current_state.physics_update() 
	

func _input(event: InputEvent) -> void:
	if current_state: 
		current_state.handle_input(event)


func change_state(new_state_name:String) -> void:
	if current_state:
		current_state.exit()
	
	var new_state=states[new_state_name.to_lower()]
	current_state=new_state
	current_state.enter()
