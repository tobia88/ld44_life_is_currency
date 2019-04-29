extends KinematicBody2D
var motion = Vector2()
const ACCEL = 0.5
const DECEL = 0.17
const MAXSPD = 900
const GRV = 0.45
const MAXY = 900
const UP = Vector2(0,-1)

func _physics_process(delta):
    if !is_on_floor():
        motion.y = clamp(motion.y + GRV * delta, -MAXY, MAXY)
        
    if Input.is_action_pressed("right"):
        motion.x = clamp(motion.x + ACCEL * delta, -MAXSPD, MAXSPD)
    elif Input.is_action_pressed("left"):
        motion.x = clamp(motion.x + -ACCEL * delta, -MAXSPD, MAXSPD)
    else:
        motion.x = max(-sign(motion.x) * DECEL * delta, 0)
    
    if is_on_floor() && Input.is_action_pressed("shoot"):
        motion.y = -400
    move_and_slide(motion,UP)
    pass