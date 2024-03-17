@tool

class_name ProgressBar3D extends Node3D


 
@onready var origin: Node3D
@onready var bgr_bar: MeshInstance3D
@onready var progress: MeshInstance3D

func _ready():
	set_progress_size(100)


func _init():
	origin = Node3D.new()
	bgr_bar = MeshInstance3D.new()
	progress = MeshInstance3D.new()

	add_child(origin)
	#origin.add_child(bgr_bar)
	origin.add_child(progress)

	#bgr_bar.mesh = BoxMesh.new()
	progress.mesh = BoxMesh.new()

	#bgr_bar.material_override = StandardMaterial3D.new()
	progress.material_override = StandardMaterial3D.new()
#                    0          1          2            3          4
#bilboard mode:  "DISABLED", "ENABLED", "FIXED_Y", "PARTICLES", "MAX"
	#bgr_bar.material_override.billboard_mode = 1
	progress.material_override.billboard_mode = 3

#shading_mode:  "UNSHADED", "PER_PIXEL", "PER_VERTEX", "MAX
	#bgr_bar.material_override.shading_mode = 0
	progress.material_override.shading_mode = 0

#cast shadows:   "OFF" "ON" "DOUBLE_SIDED" "SHADOWS_ONLY"
	#bgr_bar.cast_shadow = 0
	progress.cast_shadow = 0
	
	#bgr_bar.mesh.size = Vector3(2.1 ,0.15, 0.01)
	progress.mesh.size = Vector3(2.0 ,0.1, 0.1)
	
	#bgr_bar.material_override.albedo_color = Color.BLACK
	progress.material_override.albedo_color = Color.CRIMSON
	
	#bgr_bar.position.y += 1.2
	progress.position.y += 1.2
	
	
func set_progress_size(actual_health):
	var percentage = float(actual_health) / 100.0
	print(actual_health, " ", percentage)
	
	progress.mesh.size.x = progress.mesh.size.x * percentage
	#progress.position.x  -= percentage/2
	pass
	



	
