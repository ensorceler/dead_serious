extends CharacterBody2D
class_name Player

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
	handle_shooting()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_weapon"):
		handle_weapon_switch()


func handle_shooting():
	current_weapon.shoot()

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
