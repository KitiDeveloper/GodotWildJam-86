extends CharacterBody3D

@onready var Player = $"../Player"

var turn_speed = 10

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var SPEED: float = 3.0

var _last_dist := 1e9
var _stuck_time := 0.0

@export var next_points: Array[NodePath] = []
@export var wait_min: float
@export var wait_max: float
@export var arrival_radius: float

func _physics_process(_delta: float) -> void:
	var ai_pos = global_position
	var player_pos = Player.global_position
	
	var dirR = player_pos - ai_pos
	dirR.y = 0
	
	var desired_yaw = atan2(dirR.x, dirR.z)
	var current_yaw = rotation.y
	
	rotation.y = lerp_angle(current_yaw, desired_yaw, clamp(turn_speed * _delta, 0.0, 1.0))
	
	if nav_agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		return

	var current: Vector3 = global_transform.origin
	var next: Vector3 = nav_agent.get_next_path_position()
	var dir: Vector3 = next - current
	var dist := dir.length()

	# --- very small unstick check (only adds ~5 lines) ---
	if dist > _last_dist - 0.01:
		_stuck_time += _delta
	else:
		_stuck_time = 0.0
	_last_dist = dist

	if dist > 0.1:
		var move_dir := dir.normalized()

		# if stuck ~0.2s, nudge sideways a bit and force a quick repath
		if _stuck_time > 0.2:
			var side := Vector3(-move_dir.z, 0, move_dir.x) # 90° lateral
			if (randi() & 1) == 0:
				side = -side
			move_dir = (move_dir + side * 1.6).normalized()
			nav_agent.target_position = nav_agent.target_position
			_stuck_time = 0.0

		velocity = move_dir * SPEED
	else:
		velocity = Vector3.ZERO

	move_and_slide()

func update_target_location(target_location: Vector3) -> void:
	nav_agent.target_position = target_location

# (these two weren’t connected and can fight with your manual move; safe to keep or delete)
func _on_navigation_agent_3d_target_reached() -> void:
	print("in range")

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	# comment out to avoid double movement if not using avoidance
	# velocity = velocity.move_toward(safe_velocity, 0.25)
	pass
