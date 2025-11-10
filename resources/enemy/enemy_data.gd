extends Resource

class_name EnemyData

enum EnemyType {
	ZOMBIE,
	PUNCHER,
	ZOMBIE_COP,
	SKELETON,
	DEMON,
	BOSS
}

@export var enemy_type: EnemyType
@export var enemy_name: String = "Zombie"

# Stats
@export_group("Stats")
@export var health: int = 100
@export var speed: float = 25
@export var damage: int = 10
@export var attack_range: float = 3
@export var attack_cooldown: float = 1.5


# Visuals
@export_group("Visuals")
@export var sprite_frames: SpriteFrames  # AnimatedSprite2D animations
@export var scale_factor: float = 1.0
@export var sprite_position_offset:Vector2 = Vector2(0,0);
@export var color_modulate: Color = Color.WHITE

# Audio (optional)
@export_group("Audio")
@export var attack_sound: AudioStream
@export var death_sound: AudioStream
