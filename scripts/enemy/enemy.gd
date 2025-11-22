class_name Enemy
extends CharacterBody2D


@export var SPEED = 25
@export var ATTACK_RANGE = 17
@export var ATTACK_COOLDOWN = 1.5
@export var health=100

# detects player
var detected_player:Node2D
var is_player_detected=false

@export var enemy_data:EnemyData

@onready var character_sprite: AnimatedSprite2D = $CharacterSprite
@onready var health_bar: HealthBar = $HealthBar
@onready var state_machine: EnemyStateMachine = $StateMachine

@onready var debug_label:Label=$DebugLabel
@onready var nav2d:NavigationAgent2D=$NavigationAgent2D


func _ready() -> void:
	# add the spriteframes 
	character_sprite.sprite_frames=enemy_data.sprite_frames
	character_sprite.offset=enemy_data.sprite_position_offset
	character_sprite.scale=Vector2(enemy_data.scale_factor,enemy_data.scale_factor)
	
	health_bar.health=health
	health_bar.health_depleted.connect(_on_health_depleted)
	
	GlobalSignals.player_position_changed.connect(_on_player_position_changed)
	

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("right_click"):
		nav2d.target_position = get_global_mouse_position()
		
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	detected_player=body
	is_player_detected=true


func _on_detection_area_body_exited(body: Node2D) -> void:
	detected_player=null
	is_player_detected=false


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	print('bullet entered',body)
	

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		var bullet:Bullet = area 
		health_bar.take_damage(bullet.damage)
		bullet.queue_free()
		

func _on_health_depleted():
	queue_free()
	
func _on_player_position_changed(player_position:Vector2):
	# set nav agent target position as player position
	nav2d.target_position=player_position
