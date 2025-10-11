extends CharacterBody3D

const SPEED = 5.0
const ROTATE_TIME = 0.2   # how long the rotation tween lasts

var can_rotate: bool = true
var tw: Tween

@onready var rotate_cooldown: Timer = $"../RotateCoolDown"

func _ready() -> void:
	rotate_cooldown.timeout.connect(_on_rotate_cooldown_timeout)

	
func _physics_process(delta: float) -> void:
	# --- movement ---
	var input_dir := Input.get_vector("Movement Left", "Movement Right", "Movement Up", "Movement Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# --- rotation ---
	if not can_rotate:
		return  # block input until cooldown done

	if Input.is_action_just_pressed("Rotate Camera Left"):
		_start_rotation(90)
	elif Input.is_action_just_pressed("Rotate Camera Right"):
		_start_rotation(-90)
		
func _start_rotation(angle_deg: float) -> void:
	can_rotate = false

	# cancel old tween if it's still running
	if tw and tw.is_running():
		tw.kill()

	var target_rot = rotation.y + deg_to_rad(angle_deg)
	tw = get_tree().create_tween()
	tw.tween_property(self, "rotation:y", target_rot, ROTATE_TIME)\
	   .set_trans(Tween.TRANS_QUAD)\
	   .set_ease(Tween.EASE_OUT)

	# start cooldown timer same length as tween
	rotate_cooldown.start(ROTATE_TIME)

func _on_rotate_cooldown_timeout() -> void:
	can_rotate = true
