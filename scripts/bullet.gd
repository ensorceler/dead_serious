extends Area2D
class_name Bullet

@export var lifetime: int = 3
@export var speed: int = 100
@export var damage: float

var direction: Vector2 = Vector2.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	position += speed * direction * delta


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	rotation = direction.angle()


func _on_lifetime_timeout() -> void:
	queue_free()
