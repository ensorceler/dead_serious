extends ProgressBar
class_name HealthBar

@export var health:float=100;
@export var min_health:int=0;

signal health_depleted 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = health


func take_damage(damage:float)->void:
	if (value-damage)>=min_health:
		value=value-damage
	else: 
		print("going below")
		print("DEATH")
		value=min_health
		health_depleted.emit()
		
