extends CharacterBody3D
@onready var my_camera = $MyCamera
@onready var idle_timer = $Princess/IdleTimer
@onready var animation_player = $Princess/AnimationPlayer

enum PlayerStates {ATTACKING,NORMAL}
var state = PlayerStates.NORMAL
const SPEED = 8.8 
const JUMP_VELOCITY = 4.5
const MOUSE_SPEED = 0.2 * (PI/180) 
const CAM_SPEED = 0.2 * (PI/180)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")#

func attack():
	state = PlayerStates.ATTACKING
	
func non_attack():
	state = PlayerStates.NORMAL
func get_player_state():
	return state
	

func _ready():
	# setup loop for animation I cant find this in Godot so did it via code
	'''
	var animations_name = ['Run', 'Idle', 'Idle2', 'Walk']
	for a in animations_name:  
		var animation = animation_player.get_animation(a)
		animation.loop = true
	'''
	#hide mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	
	


	
func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		#  rotate taking arg in rad
		rotate_y(-event.relative.x * MOUSE_SPEED)
		my_camera.rotate_x(-event.relative.y * CAM_SPEED)
				
		
func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("SwordAttack"):
		if animation_player.current_animation != "SwordAttack":
			animation_player.play("SwordAttack")
			#change_state(PlayerStates.ATTACK)
		#animation_player.play("Die")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplad actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if animation_player.current_animation !="Run":
			animation_player.play("Run")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	else:		
		#animation_player.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	stop_animation_when_you_didnt_move()

func _on_idle_timer_timeout():
	if animation_player.current_animation =="SwordAttack":
		return
	
	if animation_player.current_animation !="Idle2":
		animation_player.play("Idle2")
#		idle_timer. 
	
func stop_animation_when_you_didnt_move():
	if (
		Input.is_action_just_released("forward") or
		Input.is_action_just_released("backward") or
		Input.is_action_just_released("left") or
		Input.is_action_just_released("right") 
	):
		if animation_player.current_animation == "Run":
			animation_player.stop()
