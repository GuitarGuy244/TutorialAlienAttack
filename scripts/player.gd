extends CharacterBody2D

signal took_damage 

@export var speed = 500
@onready var rocket_shot_sound = $RocketShotSound
var rscene = load("res://scenes/rocket.tscn")

#var rocket_container
@onready var rocket_container = $RocketContainer # = get_node("RockerContainer")
#same as line above
#func _ready():
#	rocket_container = get_node("RocketContainer")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func _physics_process(delta):
	velocity = Vector2(0,0) #makes sure that every frame velocity is reset so player doesn't keep moving
	
	#player movement WASD
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		
	move_and_slide()
	
	#sets boundaries for game player in game window, 3 ways to do it
	var screen_size = get_viewport_rect().size
	#1st way of setting boundaries
#	if global_position.x < 0:
#		global_position.x = 0
#	if global_position.x > screen_size.x:
#		global_position.x = screen_size.x
#	if global_position.y < 0:
#		global_position.y = 0
#	if global_position.y > screen_size.y:
#		global_position.y = screen_size.y
		
	#2nd way of setting boundaries
#	global_position.x = clampf(global_position.x, 0, screen_size.x)
#	global_position.y = clampf(global_position.y, 0, screen_size.y)
	
	#3rd way of setting boundaries
	global_position = global_position.clamp(Vector2(0,0), screen_size)
		
func shoot():
#	var rocket_scene = preload("res://scenes/rocket.tscn")
#	var rocket_instance = rocket_scene.instantiate()
	var rocket_instance = rscene.instantiate()
	#add_child(rocket_instance)
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 65
	rocket_shot_sound.play()

func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
	
