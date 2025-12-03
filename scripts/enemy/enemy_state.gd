class_name EnemyState
extends Node

enum EnemyStateType { IDLE, WALK, CHASE, ATTACK, DEATH }

var state_machine: EnemyStateMachine
var enemy: Enemy


func _init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func update() -> void:
	pass


func physics_update() -> void:
	pass


func handle_input(_input: InputEvent) -> void:
	pass
