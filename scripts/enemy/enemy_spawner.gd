class_name EnemySpawner
extends Node2D

@export var enemy_count = 50
@export var enemy_scene:PackedScene;
var spawn_rect:Array[Polygon2D]=[]


@onready var spawn_zones: Node2D = $SpawnZones

func _ready() -> void:
	for zone in spawn_zones.get_children():
		spawn_rect.push_back(zone)
	
	var zone:Polygon2D=spawn_rect[0]
	print("zone =>",zone)
	
	
	for i in range(enemy_count):
		print("enemy_#",i)
		var enemy:Enemy=enemy_scene.instantiate()
		print('enemy =>',enemy,'\n')
		var rand_position=get_random_position(zone)
		print('rand_position',rand_position)
		enemy.global_position=rand_position
		add_child(enemy)
		
func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	pass


func get_random_position(poly) -> Vector2:
	var points = poly.polygon
	
	# Assuming rectangle with 4 points: [top-left, top-right, bottom-right, bottom-left]
	var width = points[1].x - points[0].x
	var height = points[2].y - points[1].y
	
	var random_x = randf_range(0, width)
	var random_y = randf_range(0, height)
	
	return Vector2(random_x, random_y)
