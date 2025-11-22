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

@export_group("Gun Position")
@export var weapon_adjust_left:Vector2=Vector2(-7,0);
@export var weapon_adjust_right:Vector2=Vector2(8,0);

@export var gun_sprite_adjust_left:Vector2=Vector2(0,1);
@export var gun_sprite_adjust_right:Vector2=Vector2(0,0);

@export var muzzle_adjust_left:Vector2=Vector2(5,1.5);
@export var muzzle_adjust_right:Vector2=Vector2(5,-1); 
