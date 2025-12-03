class_name Player
extends CharacterBody2D

var face_direction="right"
var current_health:int;

@export var speed:int=60
@export var max_health:int=100

# Preload weapon resources
const PISTOL = preload("res://resources/weapon/pistol.tres")
const SHOTGUN = preload("res://resources/weapon/shotgun.tres")
const UZI = preload("res://resources/weapon/uzi.tres")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var current_weapon: WeaponBase = $Weapon
@onready var crosshair: Sprite2D = $Crosshair
@onready var state_machine: PlayerStateMachine = $StateMachine



var available_weapons:Array[Weapon_Data]=[]
var current_weapon_index:int=0

func _ready() -> void:
	available_weapons=[PISTOL,SHOTGUN,UZI]
	pass



func _physics_process(delta: float) -> void:
	handle_aiming()

func _unhandled_input(event: InputEvent)-> void:
	# Check if event is a key/button press, not mouse motion
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
		if event.is_action_pressed("shoot"):
			handle_shooting()
		if event.is_action_pressed("switch_weapon"):
			handle_weapon_switch()
		if event.is_action_pressed("reload"):	
			handle_reloading()

func handle_shooting():
	current_weapon.shoot()

func handle_reloading():
	print("reload weapon")
	current_weapon.reload()
	
func handle_aiming() -> void:
	var mouse_pos = get_global_mouse_position()
	crosshair.global_position=mouse_pos
	  # Store hand's default position
	if mouse_pos.x < global_position.x:
		# Facing left
		face_direction = "left"
		animated_sprite.flip_h = true	
	else:
		# Facing right
		face_direction = "right"
		animated_sprite.flip_h = false
	
	current_weapon.update_direction(face_direction,mouse_pos)

func handle_weapon_switch() ->void:
	current_weapon_index+=1 
	current_weapon.weapon_data=available_weapons[current_weapon_index%3]
	print("current_weapon =>",current_weapon)
	current_weapon.load_weapon_data()
