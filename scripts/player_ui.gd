extends CanvasLayer

@onready var weapon_ui: TextureRect = $MarginContainer/VBoxContainer/Weapon/HBoxContainer/TextureRect
@onready var ammo_label: Label = $MarginContainer/VBoxContainer/Weapon/HBoxContainer/PanelContainer/Label


func _ready() -> void:
	GlobalSignals.player_weapon_changed.connect(_on_player_weapon_changed)
	GlobalSignals.weapon_ammo_changed.connect(_on_weapon_ammo_changed)

func _on_player_weapon_changed(weapon_selected: Weapon_Data) -> void:
	print("weapon_selected, gun_skin", weapon_selected,weapon_selected.gun_skin)
	weapon_ui.texture = weapon_selected.gun_skin


func _on_weapon_ammo_changed(current_ammo:int, reserve_ammo:int)->void:
	print("current ammo and reserve ammo",current_ammo, reserve_ammo)
	ammo_label.text="%s \\ %s" % [current_ammo, reserve_ammo]
	
