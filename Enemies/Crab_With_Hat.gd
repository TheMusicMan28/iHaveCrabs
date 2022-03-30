extends KinematicBody2D

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
enum{
	IDLE,
	WANDER,
	CHASE
}

var fireball = preload("res://Enemies/Fireball.tscn")

export var HIT_POINTS = 25
export var FRICTION = 200
export var VELOCITY = Vector2.ZERO
export var ACCELERATION = 200
export var MAX_SPEED = 15
export var WANDER_TARGET_RANGE = 4

var knockback = Vector2.ZERO
var state = IDLE
var fireballLoop = 50

onready var sprite = $AnimatedSprite
onready var hurtbox = $HurtBox
onready var scream = $WilhelmScream
onready var zoneOfTruth = $PlayerDetectionZone
onready var wanderController = $Wander_Controller
onready var geraldStats = PlayerStats


func _ready():
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	HIT_POINTS = 25

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			VELOCITY = VELOCITY.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = zoneOfTruth.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				VELOCITY = VELOCITY.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				$FireStarter.rotate($FireStarter.get_angle_to(player.global_position))
				if fireballLoop == 50:
					fire(player)
					fireballLoop = 1
				else:
					fireballLoop += 1
			else:
				state = IDLE
	VELOCITY = move_and_slide(VELOCITY)

func seek_player():
	if zoneOfTruth.can_see_player():
		state = CHASE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	VELOCITY = VELOCITY.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func fire(player):
	var fire = fireball.instance()
	owner.add_child(fire)
	fire.transform = $FireStarter.global_transform


func _on_HurtBox_area_entered(area):
	HIT_POINTS -= geraldStats.damage
	if HIT_POINTS <= 0:
		print("Wizard Crab Killed!")
		scream.play()
		queue_free()
	else:
		knockback = area.knockback_vector * 100
		print("Wizard Crab has " + str(HIT_POINTS) + " Hit Points Left")