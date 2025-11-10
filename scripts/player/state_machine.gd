extends Node
class_name PlayerStateMachine


@export var initial_state:PlayerState
var current_state: PlayerState
var states: Dictionary = {}



func _ready() -> void:
	await owner.ready
	
	for child:PlayerState in get_children():
		states[child.name.to_lower()]=child
		child.state_machine=self
		child.player=get_parent()
		
	if initial_state:
		current_state=initial_state
		initial_state.enter()
	
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state(new_state_name:String) -> void:

	if current_state:
		current_state.exit()
		
	var new_state=states[new_state_name]
	current_state=new_state
	new_state.enter()
	
