extends CharacterBody3D

var speed = 5.0
var current_dir = "South"
var is_running = false

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

func _physics_process(delta):
	player_movement(delta)
	play_anim()
	muzzle_fx()
	
	if Input.is_action_just_pressed("Rotate Camera Left"):
		rotation_degrees.y += 90  # snap the root (and all children) to 90°
	elif Input.is_action_just_pressed("Rotate Camera Right"):
		rotation_degrees.y += -90  # snap the root (and all children) to 90°

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
		
	
	global_position.y = 1.4
	move_and_slide()
	global_position.y = 1.4
	

func muzzle_fx():
	if Input.is_action_just_pressed("Fire"):
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
