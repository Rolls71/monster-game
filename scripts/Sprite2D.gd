extends Sprite2D

var angular_speed = PI
var directional_speed = 400.0

func _process(delta):
	var d = 0
	if Input.is_action_pressed("ui_left"):
		d += -1
	if Input.is_action_pressed("ui_right"):
		d += 1
	
	rotation += angular_speed * d * delta
	
	d = 0
	if Input.is_action_pressed("ui_up"):
		d += 1
	if Input.is_action_pressed("ui_down"):
		d += -1		
	
	var _vel = Vector2.UP.rotated(rotation) * directional_speed * d
	position += _vel * delta

