extends MeshInstance3D
 
@onready var area_3d = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	area_3d.area_entered.connect(on_area_entered)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func on_area_entered(other_area: Area3D ):
	print("Get damage")
