extends KinematicBody2D

#Cria-se uma variável Motion para poder lidar com objetos físicos em 2D.
var motion = Vector2()

const SPEED = 100
const GRAVITY = 200
const JUMPSPEED = -300
const UP = Vector2(0, -1)


#physics_process cuida do movimento do personagem.
func _physics_process(delta):
	update_motion(delta)

func jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMPSPEED
		

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		motion.y += GRAVITY * delta

func walk():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") :
		motion.x = -SPEED
	else:
		motion.x = 0

func _process(delta):
	$AnimatedSprite.update_animations(motion)

func update_animation():
	$AnimatedSprite.update(motion)
	
func update_motion(delta):
	fall(delta)
	walk()
	jump()
	move_and_slide(motion, UP)