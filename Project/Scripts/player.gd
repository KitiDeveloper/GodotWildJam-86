extends CharacterBody3D

var speed = 5.0
var current_dir = "South"
var is_running = false

#--------------------------------------------
#camera stuff
@onready var cam: Camera3D = $Camera3D

var cam_base_rot: Vector3
var cam_base_pos: Vector3


# shake state
var shake_t := 0.0
var shake_dur := 0.0
var shake_amp_pos := 0.0      # in meters
var shake_amp_rot := 0.0      # in radians
#--------------------------------------------
#muzzle juice
@onready var muzzle_flashes = [
	$MuzzleFX/MuzzleFlashN,
	$MuzzleFX/MuzzleFlashNE,
	$MuzzleFX/MuzzleFlashE,
	$MuzzleFX/MuzzleFlashSE,
	$MuzzleFX/MuzzleFlashS,
	$MuzzleFX/MuzzleFlashSW,
	$MuzzleFX/MuzzleFlashW,
	$MuzzleFX/MuzzleFlashNW
]

@onready var muzzle_anim = [
	$MuzzleFX/MuzzleAnimN,
	$MuzzleFX/MuzzleAnimNE,
	$MuzzleFX/MuzzleAnimE,
	$MuzzleFX/MuzzleAnimSE,
	$MuzzleFX/MuzzleAnimS,
	$MuzzleFX/MuzzleAnimSW,
	$MuzzleFX/MuzzleAnimW,
	$MuzzleFX/MuzzleAnimNW
]
#--------------------------------------------

@export var world_env_path: WorldEnvironment
@onready var env: Environment = world_env_path.environment

var base_sat := 1.0
var base_brightness := 0.0
var base_glow := 0.0

func _ready():
	#--------------------------------------------
	#for camera
	cam_base_rot = cam.rotation
	cam_base_pos = cam.position
	#--------------------------------------------
	world_env_path.environment = world_env_path.environment.duplicate()
	env = world_env_path.environment

	# Enable the features
	env.adjustment_enabled = true
	env.glow_enabled = true
	
	# Cache baselines
	base_sat = env.adjustment_saturation
	base_brightness = env.adjustment_brightness
	base_glow = env.glow_intensity

func _physics_process(delta):
	
	player_movement(delta)
	rotate_player()
	play_anim()
	muzzle_fx()
	

func player_movement(_delta):
	
	if Input.is_action_pressed("Movement Up") and Input.is_action_pressed("Movement Right"):
		current_dir = "NorthEast"
		is_running = true
		velocity.z = -speed
		velocity.x = speed
	elif Input.is_action_pressed("Movement Right") and Input.is_action_pressed("Movement Down"):
		current_dir = "SouthEast"
		is_running = true
		velocity.x = speed
		velocity.z = speed
	elif Input.is_action_pressed("Movement Down") and Input.is_action_pressed("Movement Left"):
		current_dir = "SouthWest"
		is_running = true
		velocity.z = speed
		velocity.x = -speed
	elif Input.is_action_pressed("Movement Left") and Input.is_action_pressed("Movement Up"):
		current_dir = "NorthWest"
		is_running = true
		velocity.x = -speed
		velocity.z = -speed
	elif Input.is_action_pressed("Movement Up"):
		current_dir = "North"
		is_running = true
		velocity.z = -speed
		velocity.x = 0
	elif Input.is_action_pressed("Movement Right"):
		current_dir = "East"
		is_running = true
		velocity.x = speed
		velocity.z = 0
	elif Input.is_action_pressed("Movement Down"):
		current_dir = "South"
		is_running = true
		velocity.z = speed
		velocity.x = 0
	elif Input.is_action_pressed("Movement Left"):
		current_dir = "West"
		is_running = true
		velocity.x = -speed
		velocity.z = 0
	else:
		is_running = false
		velocity.x = 0
		velocity.z = 0
		
	var right   := global_transform.basis.x
	var forward := global_transform.basis.z   # flipped direction

	right.y = 0
	forward.y = 0
	right = right.normalized()
	forward = forward.normalized()

	var world := right * velocity.x + forward * velocity.z
	velocity.x = world.x
	velocity.z = world.z
	velocity.y = 0
	
	global_position.y = 1.4
	move_and_slide()
	global_position.y = 1.4
	
func rotate_player():
	if Input.is_action_just_pressed("Rotate Camera Left"):
		rotation_degrees.y += 90  # snap the root (and all children) to 90°
		if current_dir == "North":
			current_dir = "East"
		elif current_dir == "NorthWest":
			current_dir = "NorthEast"
		elif current_dir == "West":
			current_dir = "North"
		elif current_dir == "SouthWest":
			current_dir = "NorthWest"
		elif current_dir == "South":
			current_dir = "West"
		elif current_dir == "SouthEast":
			current_dir = "SouthWest"
		elif current_dir == "East":
			current_dir = "South"
		elif current_dir == "NorthEast":
			current_dir = "SouthEast"
	elif Input.is_action_just_pressed("Rotate Camera Right"):
		rotation_degrees.y -= 90  # snap the root (and all children) to -90°
		if current_dir == "North":
			current_dir = "West"
		elif current_dir == "NorthEast":
			current_dir = "NorthWest"
		elif current_dir == "East":
			current_dir = "North"
		elif current_dir == "SouthEast":
			current_dir = "NorthEast"
		elif current_dir == "South":
			current_dir = "East"
		elif current_dir == "SouthWest":
			current_dir = "SouthEast"
		elif current_dir == "West":
			current_dir = "South"
		elif current_dir == "NorthWest":
			current_dir = "SouthWest"

func muzzle_fx():
	if Input.is_action_just_pressed("Fire"):
		camera_kick(randf_range(-1, 1), 1, randf_range(-1, 1), 0.08)
		env_kick()
		match current_dir:
			"North":
				muzzle_flashes[0].visible = true
				muzzle_anim[0].visible = true
				muzzle_anim[0].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[0].visible = false
				muzzle_anim[0].visible = false
			"NorthEast":
				muzzle_flashes[1].visible = true
				muzzle_anim[1].visible = true
				muzzle_anim[1].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[1].visible = false
				muzzle_anim[1].visible = false
			"East":
				muzzle_flashes[2].visible = true
				muzzle_anim[2].visible = true
				muzzle_anim[2].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[2].visible = false
				muzzle_anim[2].visible = false
			"SouthEast":
				muzzle_flashes[3].visible = true
				muzzle_anim[3].visible = true
				muzzle_anim[3].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[3].visible = false
				muzzle_anim[3].visible = false
			"South":
				muzzle_flashes[4].visible = true
				muzzle_anim[4].visible = true
				muzzle_anim[4].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[4].visible = false
				muzzle_anim[4].visible = false
			"SouthWest":
				muzzle_flashes[5].visible = true
				muzzle_anim[5].visible = true
				muzzle_anim[5].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[5].visible = false
				muzzle_anim[5].visible = false
			"West":
				muzzle_flashes[6].visible = true
				muzzle_anim[6].visible = true
				muzzle_anim[6].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[6].visible = false
				muzzle_anim[6].visible = false
			"NorthWest":
				muzzle_flashes[7].visible = true
				muzzle_anim[7].visible = true
				muzzle_anim[7].play()
				await get_tree().create_timer(0.1).timeout
				muzzle_flashes[7].visible = false
				muzzle_anim[7].visible = false

func play_anim():
	var anim = $AnimatedSprite3D
	
	if current_dir == "North":
		if is_running == true:
			anim.play("Run_N")
		else:
			anim.play("Idle_N")
	elif current_dir == "NorthEast":
		if is_running == true:
			anim.play("Run_NE")
		else:
			anim.play("Idle_NE")
	elif current_dir == "East":
		if is_running == true:
			anim.play("Run_E")
		else:
			anim.play("Idle_E")
	elif current_dir == "SouthEast":
		if is_running == true:
			anim.play("Run_SE")
		else:
			anim.play("Idle_SE")
	elif current_dir == "South":
		if is_running == true:
			anim.play("Run_S")
		else:
			anim.play("Idle_S")
	elif current_dir == "SouthWest":
		if is_running == true:
			anim.play("Run_SW")
		else:
			anim.play("Idle_SW")
	elif current_dir == "West":
		if is_running == true:
			anim.play("Run_W")
		else:
			anim.play("Idle_W")
	elif current_dir == "NorthWest":
		if is_running == true:
			anim.play("Run_NW")
		else:
			anim.play("Idle_NW")
	else:
		return

func camera_kick(yaw_deg: float = 0.0, pitch_deg: float = 2.5, roll_deg: float = 0.0, duration: float = 0.10):
	var target := cam_base_rot + Vector3(
		deg_to_rad(pitch_deg),
		deg_to_rad(yaw_deg),
		deg_to_rad(roll_deg)
	)
	var tw = create_tween()
	tw.tween_property(cam, "rotation", target, duration * 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(cam, "rotation", cam_base_rot, duration * 0.65).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func env_kick(sat_add := 1.0, glow_add := 50.0, duration := 0.20):
	var tw = create_tween()
	tw.tween_property(env, "adjustment_saturation", base_sat + sat_add, duration * 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(env, "glow_intensity", base_glow + glow_add, duration * 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(env, "adjustment_saturation", base_sat, duration * 0.65).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tw.parallel().tween_property(env, "glow_intensity", base_glow, duration * 0.65).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
