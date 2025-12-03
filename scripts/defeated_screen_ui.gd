extends CanvasLayer

@onready var defeat_control: Control = $DefeatControl

func _ready() -> void:
	visible = false

func _input(_event):
	pass
	'''
	if visible:
		get_viewport().set_input_as_handled()
	'''
