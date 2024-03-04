extends CharacterBody3D
@onready var my_camera = $MyCamera


@onready var animation_player = $Princess/AnimationPlayer

const SPEED = 2.8 
const JUMP_VELOCITY = 4.5
const MOUSE_SPEED = 0.2 * (PI/180) 
const CAM_SPEED = 0.2 * (PI/180)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")#


func _ready():
	# setup loop for animation I cant find this in Godot so did it via code
	var animations_name = ['Run', 'Idle', 'Idle2', 'Walk']
	for a in animations_name:  
		var animation = animation_player.get_animation(a)
		animation.loop = true
	
	#hide mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
	
		


	
func _input(event):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		#  rotate taking arg in rad
		rotate_y(-event.relative.x * MOUSE_SPEED)
		my_camera.rotate_x(-event.relative.y * CAM_SPEED)
				
		
func _physics_process(delta):
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
		if animation_player.current_animation !="Walk":
			animation_player.play("Walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation !="Idle2":
			animation_player.play("Idle2")
		#animation_player.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
