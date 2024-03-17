extends CharacterBody3D
@export var deathParticle : PackedScene
@onready var area_3d = $Area3D
@onready var player = $"../Player"
@onready var enemy_health3D = $ProgressBar3D
#@onready var progress_bar = "SubViewport/ProgressBar"  
#@onready var progress_bar = $SubViewport/ProgressBar




var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	#ProgressBar3D.new().
	area_3d.area_entered.connect(on_area_entered)
	#progress_bar.value = 100
	pass
	

func take_damage(damage):
	health = max(health - damage,0)
	enemy_health3D.set_progress_size(health)
	
	if health <= 0:
		enemy_die()


func on_area_entered(other_area: Area3D ):
		if player.get_player_state() == player.PlayerStates.ATTACKING:
			take_damage(40)

func enemy_die():
	var _particle = deathParticle.instantiate()
	 
	var coord3d_to2d = $"../Player/MyCamera/Camera3D".unproject_position(global_position) 
	coord3d_to2d.y -=70 
	_particle.position = coord3d_to2d
	#_particle.position.y = enemy.position.y
	_particle.emitting = true
	#enemy.add_child(_particle)
	get_tree().current_scene.add_child(_particle)
	queue_free()
