extends CharacterBody2D

class_name Enemy


@export var SPEED = 25
@export var ATTACK_RANGE = 3
@export var ATTACK_COOLDOWN = 1.5
@export var health=100

var player:Node2D
var detected_player:Node2D

var is_player_detected=false


@export var enemy_data:EnemyData

@onready var character_sprite: AnimatedSprite2D = $CharacterSprite
@onready var health_bar: HealthBar = $HealthBar
@onready var state_machine: EnemyStateMachine = $StateMachine


func _ready() -> void:
	# add the spriteframes 
	character_sprite.sprite_frames=enemy_data.sprite_frames
	character_sprite.offset=enemy_data.sprite_position_offset
	character_sprite.scale=Vector2(enemy_data.scale_factor,enemy_data.scale_factor)
	
	health_bar.health=health
	health_bar.health_depleted.connect(_on_health_depleted)

	
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
		print('bullet entered',area)
		var bullet:Bullet = area 
		health_bar.take_damage(bullet.damage)
		bullet.queue_free()
		
func _on_health_depleted()->void:
	pass
	
