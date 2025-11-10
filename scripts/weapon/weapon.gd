extends Node2D
class_name WeaponBase

@export var bullet_scene:PackedScene;
@export var weapon_data:Weapon_Data

# weapon_position
@export var weapon_pos_right: Vector2 = Vector2(8, 0)
@export var weapon_pos_left: Vector2 = Vector2(-8,0)
@export var gun_sprite_pos_left: Vector2 = Vector2(0, 1)
@export var gun_sprite_pos_right: Vector2 = Vector2(0, 0)
@export var muzzle_pos_left:Vector2 = Vector2(5,-1);
@export var muzzle_pos_right:Vector2 = Vector2(5,-1);


# References to child nodes
@onready var gun_sprite: AnimatedSprite2D = $Gun
@onready var hand_sprite: AnimatedSprite2D = $Hand
@onready var muzzle: Marker2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var sfx_shoot: AudioStreamPlayer2D = $sfx_shoot


var is_shooting:bool=false
var can_shoot:bool=true


func _ready():
	gun_sprite.scale=Vector2(weapon_data.weapon_scale,weapon_data.weapon_scale)
	gun_sprite.sprite_frames=weapon_data.gun_spriteframes
	#play gun animation
	gun_sprite.play(weapon_data.gun_animation)
	# set fire-rate to the fire_timer
	fire_timer.wait_time=weapon_data.fire_rate
	
func _physics_process(delta: float) -> void:
	pass


	
func update_direction(weapon_direction:String,mouse_pos:Vector2):
	if weapon_direction=="left":
		gun_sprite.flip_v = true
		gun_sprite.position=gun_sprite_pos_left
		muzzle.position=muzzle_pos_left
		# accounts for the weapon position offset when player faces left
		position = weapon_pos_left
		
	else:
		gun_sprite.flip_v = false
		gun_sprite.position=gun_sprite_pos_right
		muzzle.position=muzzle_pos_right
		# accounts for the weapon position offset when player faces right
		position = weapon_pos_right
		
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
			#print("shoot play ",weapon_datxssa.shoot_animation)
			gun_sprite.play(weapon_data.shoot_animation)
		
		can_shoot = false
		sfx_shoot.play()
		fire_timer.start()
	
	
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
