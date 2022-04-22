extends Node2D

signal room_cleared

var total_crabs = 15
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab
onready var crab2 = $Enemies/Crab2
onready var crab3 = $Enemies/Crab3
onready var crab4 = $Enemies/Crab4
onready var crab5 = $Enemies/Crab5
onready var crab6 = $Enemies/Crab6
onready var crab7 = $Enemies/Crab7
onready var crab8 = $Enemies/Crab8
onready var crab9 = $Enemies/Crab9
onready var crab10 = $Enemies/Crab10
onready var crab11 = $Enemies/Crab11
onready var crab12 = $Enemies/Crab12
onready var crab13 = $Enemies/Crab13
onready var crab14 = $Enemies/Crab14
onready var crab15 = $Enemies/Crab15

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab3.disable_collision_shapes()
	crab4.disable_collision_shapes()
	crab5.disable_collision_shapes()
	crab6.disable_collision_shapes()
	crab7.disable_collision_shapes()
	crab8.disable_collision_shapes()
	crab9.disable_collision_shapes()
	crab10.disable_collision_shapes()
	crab11.disable_collision_shapes()
	crab12.disable_collision_shapes()
	crab13.disable_collision_shapes()
	crab14.disable_collision_shapes()
	crab15.disable_collision_shapes()
	crab1.hide()
	crab2.hide()
	crab3.hide()
	crab4.hide()
	crab5.hide()
	crab6.hide()
	crab7.hide()
	crab8.hide()
	crab9.hide()
	crab10.hide()
	crab11.hide()
	crab12.hide()
	crab13.hide()
	crab14.hide()
	crab15.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.disabled = true
	crab1.reenable_collision_shapes()
	crab2.reenable_collision_shapes()
	crab3.reenable_collision_shapes()
	crab4.reenable_collision_shapes()
	crab5.reenable_collision_shapes()
	crab6.reenable_collision_shapes()
	crab7.reenable_collision_shapes()
	crab8.reenable_collision_shapes()
	crab9.reenable_collision_shapes()
	crab10.reenable_collision_shapes()
	crab11.reenable_collision_shapes()
	crab12.reenable_collision_shapes()
	crab13.reenable_collision_shapes()
	crab14.reenable_collision_shapes()
	crab15.reenable_collision_shapes()
	crab1.show()
	crab2.show()
	crab3.show()
	crab4.show()
	crab5.show()
	crab6.show()
	crab7.show()
	crab8.show()
	crab9.show()
	crab10.show()
	crab11.show()
	crab12.show()
	crab13.show()
	crab14.show()
	crab15.show()


func _on_Crab_Killed():
	total_crabs_killed += 1
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")