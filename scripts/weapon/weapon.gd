class_name WeaponBase
extends Node2D

@export var bullet_scene:PackedScene;
@export var weapon_data:Weapon_Data
@export var muzzle_flash_duration: float = 0.05  # Duration in seconds


var is_shooting:bool=false
var can_shoot:bool=true

# References to child nodes
@onready var gun_sprite: AnimatedSprite2D = $Gun
@onready var hand_sprite: AnimatedSprite2D = $Hand
@onready var muzzle: Node2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var sfx_shoot: AudioStreamPlayer2D = $sfx_shoot
@onready var muzzle_flash_timer: Timer = $MuzzleFlashTimer



func _ready():
	gun_sprite.scale=Vector2(weapon_data.weapon_scale,weapon_data.weapon_scale)
	gun_sprite.sprite_frames=weapon_data.gun_spriteframes
	#play gun animation
	gun_sprite.play(weapon_data.gun_animation)
	# set fire-rate to the fire_timer
	fire_timer.wait_time=weapon_data.fire_rate
	muzzle_flash_timer.wait_time=muzzle_flash_duration
	muzzle.visible=false
	
func _physics_process(delta: float) -> void:
	pass
	
func update_direction(weapon_direction:String,mouse_pos:Vector2):
	if weapon_direction=="left":
		gun_sprite.flip_v = true
		hand_sprite.flip_v = true
		
		gun_sprite.position=weapon_data.gun_sprite_adjust_left
		muzzle.position=weapon_data.muzzle_adjust_left
		# accounts for the weapon position offset when player faces left
		position = weapon_data.weapon_adjust_left
		
	else:
		gun_sprite.flip_v = false
		hand_sprite.flip_v = false
		
		gun_sprite.position=weapon_data.gun_sprite_adjust_right
		muzzle.position=weapon_data.muzzle_adjust_right
		# accounts for the weapon position offset when player faces right
		position = weapon_data.weapon_adjust_right
		
	look_at(mouse_pos)
	
func shoot():
	if Input.is_action_pressed("shoot") and can_shoot:
		
		var bullet:Bullet = bullet_scene.instantiate()
		# Position bullet at gun's position (adjust offset if needed)
		bullet.global_position=muzzle.global_position
		# Set bullet direction toward mouse
		var direction = (get_global_mouse_position() - muzzle.global_position).normalized()
		bullet.set_direction(direction)
		# Add bullet to scene (not as child of player!)
		get_tree().root.add_child(bullet)
		
		# play shoot animation
		if weapon_data.shoot_animation.length():
			is_shooting=true
			gun_sprite.play(weapon_data.shoot_animation)
		
		can_shoot = false
		sfx_shoot.play()
		fire_timer.start()
		muzzle.visible=true
		muzzle_flash_timer.start()
	
func load_weapon_data():
	gun_sprite.scale=Vector2(weapon_data.weapon_scale,weapon_data.weapon_scale)
	gun_sprite.sprite_frames=weapon_data.gun_spriteframes
	
	
	#play gun animation
	gun_sprite.play(weapon_data.gun_animation)
	# set fire-rate to the fire_timer
	fire_timer.wait_time=weapon_data.fire_rate
	GlobalSignals.player_weapon_changed.emit(weapon_data)

func _on_gun_animation_finished() -> void:
	#print('gun animation finished')
	if is_shooting && gun_sprite.animation==weapon_data.shoot_animation: 
		is_shooting=false
		#print("shoot stop")
		gun_sprite.play(weapon_data.gun_animation)

func _on_fire_timer_timeout() -> void:
	can_shoot = true  

func _on_muzzle_flash_timer_timeout() -> void:
	muzzle.visible=false
	# Replace with function body.
