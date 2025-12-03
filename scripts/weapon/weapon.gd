class_name WeaponBase
extends Node2D

@export var bullet_scene: PackedScene
@export var weapon_data: Weapon_Data
# Duration in seconds
@export var muzzle_flash_duration: float = 0.05

var is_shooting: bool = false
var is_reloading: bool = false
var can_shoot: bool = true

var current_ammo: int
var max_ammo: int
var reserve_ammo: int
var reload_time: float

# References to child nodes
@onready var gun_sprite: AnimatedSprite2D = $Gun
@onready var hand_sprite: AnimatedSprite2D = $Hand
@onready var muzzle: Node2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var sfx_shoot: AudioStreamPlayer2D = $sfx_shoot
@onready var muzzle_flash_timer: Timer = $MuzzleFlashTimer


func _ready():
	load_weapon_data()
	call_deferred("_weapons_emit_signal")

func load_weapon_data():
	gun_sprite.scale = Vector2(weapon_data.weapon_scale, weapon_data.weapon_scale)
	gun_sprite.sprite_frames = weapon_data.gun_spriteframes
	#play gun animation
	gun_sprite.play(weapon_data.gun_animation)
	# set fire-rate to the fire_timer
	fire_timer.wait_time = weapon_data.fire_rate
	#muzzle
	muzzle_flash_timer.wait_time = muzzle_flash_duration
	muzzle.visible = false

	#ammo related (initial data set according to weapon)
	max_ammo = weapon_data.max_ammo
	current_ammo = weapon_data.max_ammo
	reserve_ammo = weapon_data.reserve_ammo
	reload_time = weapon_data.reload_time

	GlobalSignals.weapon_ammo_changed.emit(current_ammo, reserve_ammo)
	GlobalSignals.player_weapon_changed.emit(weapon_data)

func _weapons_emit_signal():
	GlobalSignals.weapon_ammo_changed.emit(current_ammo, reserve_ammo)
	GlobalSignals.player_weapon_changed.emit(weapon_data)
	
	
func update_direction(weapon_direction: String, mouse_pos: Vector2):
	if weapon_direction == "left":
		gun_sprite.flip_v = true
		hand_sprite.flip_v = true

		gun_sprite.position = weapon_data.gun_sprite_adjust_left
		muzzle.position = weapon_data.muzzle_adjust_left
		# accounts for the weapon position offset when player faces left
		position = weapon_data.weapon_adjust_left

	else:
		gun_sprite.flip_v = false
		hand_sprite.flip_v = false

		gun_sprite.position = weapon_data.gun_sprite_adjust_right
		muzzle.position = weapon_data.muzzle_adjust_right
		# accounts for the weapon position offset when player faces right
		position = weapon_data.weapon_adjust_right

	look_at(mouse_pos)


func shoot():
	if  can_shoot and !is_reloading and current_ammo > 0:
		var bullet: Bullet = bullet_scene.instantiate()
		# Position bullet at gun's position (adjust offset if needed)
		bullet.global_position = muzzle.global_position
		bullet.damage = weapon_data.bullet_damage
		# Set bullet direction toward mouse
		var direction = (get_global_mouse_position() - muzzle.global_position).normalized()
		bullet.set_direction(direction)
		# Add bullet to scene (not as child of player!)
		get_tree().root.add_child(bullet)

		# play shoot animation
		if weapon_data.shoot_animation.length():
			is_shooting = true
			gun_sprite.play(weapon_data.shoot_animation)

		current_ammo -= 1
		GlobalSignals.weapon_ammo_changed.emit(current_ammo, reserve_ammo)

		can_shoot = false
		sfx_shoot.play()
		fire_timer.start()
		muzzle.visible = true
		muzzle_flash_timer.start()

func reload():
	is_reloading = true
	gun_sprite.play(weapon_data.reload_animation)
	await get_tree().create_timer(reload_time).timeout

	var ammo_needed = max_ammo - current_ammo
	print("ammo needed", ammo_needed)

	reserve_ammo -= ammo_needed
	current_ammo = current_ammo + ammo_needed
	#print("current ammo=>",)
	is_reloading = false

	gun_sprite.play(weapon_data.gun_animation)
	print("emit reload signal")
	GlobalSignals.weapon_ammo_changed.emit(current_ammo, reserve_ammo)

func _on_gun_animation_finished() -> void:
	#print('gun animation finished')
	if is_shooting && gun_sprite.animation == weapon_data.shoot_animation:
		is_shooting = false
		#print("shoot stop")
		gun_sprite.play(weapon_data.gun_animation)

func _on_fire_timer_timeout() -> void:
	can_shoot = true

func _on_muzzle_flash_timer_timeout() -> void:
	muzzle.visible = false
	# Replace with function body.
