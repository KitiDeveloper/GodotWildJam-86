extends CharacterBody3D

var player = null

var speed = 3.0

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)

func _physics_process(_delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	global_position.y = 1.4
	move_and_slide()
	global_position.y = 1.4
	
