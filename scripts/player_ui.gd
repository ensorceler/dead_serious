extends CanvasLayer

@onready var player_ui: CanvasLayer = $"."
@onready var weapon_ui: TextureRect = $MarginContainer/VBoxContainer/Weapon/TextureRect


func _ready() -> void:
	GlobalSignals.player_weapon_changed.connect(on_player_weapon_changed)


func on_player_weapon_changed(weapon_selected: Weapon_Data) -> void:
	print("weapon_Ui", weapon_ui)
	#print("weapons_ui")
	print("weapon_selected", weapon_selected)
	weapon_ui.texture = weapon_selected.gun_skin
	print("weapon changed in UI")
