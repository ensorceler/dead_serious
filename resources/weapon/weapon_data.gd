class_name Weapon_Data
extends Resource

enum GunType{
	PISTOL,
	SHOTGUN,
	UZI
}

@export var gun_type:GunType;



@export var weapon_scale: float = 0.5
@export var fire_rate: float = 0.3
@export var damage: int = 15
@export var bullet_speed: int = 500


@export_group("Visuals")
@export var gun_spriteframes:SpriteFrames;
@export var gun_animation:String;
@export var shoot_animation:String;
@export var reload_animation:String;
@export var gun_skin: AtlasTexture;
