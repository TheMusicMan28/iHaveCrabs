extends Node2D

var crab = preload("res://Enemies/Crab.tscn")
var rng = RandomNumberGenerator.new()

onready var gerald  = $Gerald
onready var hitSound = $Sounds/Player_Hit
onready var deathSound = $Sounds/Player_Death
onready var enemies = $Enemies
onready var geraldStats = PlayerStats
onready var bgm = $Sounds/BGM #found at https://www.youtube.com/watch?v=arN6WFqCjgw
onready var hud = $HUD
onready var pause = $HUD/Pause

func start_game():
	#Initialilze player's stats with base set
	geraldStats.hit_points = 3
	geraldStats.max_hit_points = 3
	geraldStats.damage = 25
	geraldStats.knockback_modifier = 1
	geraldStats.weapon_type = 1
	geraldStats.current_armor = 0
	geraldStats.current_weapon = 0
	gerald.position.x = 660
	gerald.position.y = 520
	bgm.play()
	$HUD.update_hp()
	$HUD.update_current_weapon()
	$map1.start_game()



func _unhandled_input(event):
	if(event.is_action_pressed("swap_weapon")):
		if(geraldStats.weapon_type == 1):
			PlayerStats.weapon_type = 2
			$HUD.update_current_weapon()
		elif(geraldStats.weapon_type == 2):
			PlayerStats.weapon_type = 1
			$HUD.update_current_weapon()
		else:
			PlayerStats.weapon_type = 1
			$HUD.update_current_weapon()
	if(event.is_action_pressed("pause")):
		get_tree().paused = true
		pause.show()

func _on_Player_hit():
	$HUD.update_hp()
	if gerald.stats.hit_points <= 0:
		deathSound.play()
		$HUD/RestartButton.show()
		$HUD/dead.show()
	else:
		hitSound.play()


func _on_HUD_unpause():
	pause.hide()
	get_tree().paused = false


func _on_HUD_restart_game():
	$map1.restart()
	start_game()
	$HUD/RestartButton.hide()
	$HUD/dead.hide()


func _on_map1_victory():
	$HUD.victory()


func _on_Begin_pressed():
	$Start_Screen/Back_Screen.hide()
	$Start_Screen/MainMenu.hide()
	start_game()

func _on_Exit_pressed():
	get_tree().quit()


func _on_map1_healed():
	$HUD.update_hp()
