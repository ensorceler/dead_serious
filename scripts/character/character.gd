class_name Character
extends CharacterBody2D

@export var speed=20;

var face_direction="left";

@onready var head: AnimatedSprite2D = %Head
@onready var hair: AnimatedSprite2D = %Hair
@onready var face: AnimatedSprite2D = %Face
@onready var bag: AnimatedSprite2D = %Bag
@onready var body: AnimatedSprite2D = %Body
@onready var clothes: AnimatedSprite2D = %Clothes

@onready var state_machine: CharacterStateMachine = $StateMachine

func _ready()-> void: 
	pass
	
func _physics_process(delta: float) -> void:
	pass 
	
	
func _process(delta: float) -> void:
	pass 


func play_animation(name:String):
	head.play(name)
	hair.play(name)
	face.play(name)
	bag.play(name)
	body.play(name)
	clothes.play(name)	

func flip_character():
	# direction can be left/right 
	
	if face_direction=="left":
		head.flip_h=false
		hair.flip_h=false 
		face.flip_h=false 
		bag.flip_h=false
		body.flip_h=false 
		clothes.flip_h=false 
		
	elif face_direction=="right":
		head.flip_h=true
		hair.flip_h=true 
		face.flip_h=true
		bag.flip_h=true
		body.flip_h=true 
		clothes.flip_h=true 
			
	
