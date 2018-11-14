# Copyright © 2018 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends RigidBody2D
class_name Paddle

# Acceleration
# There is no maximum set speed because it depends on friction
const ACCELERATION = 2400

# The friction factor applied on each step
const FRICTION = 0.9

const CAMERA_ZOOM_BASE = 1.5

# The zoom-out factor per pixel/s of movement
const CAMERA_ZOOM_FACTOR = 0.0005

var motion := Vector2()

onready var camera := $Camera2D as Camera2D
onready var tween := $Tween as Tween

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if Input.is_action_pressed("move_up"):
		motion.y -= ACCELERATION * state.step
	elif Input.is_action_pressed("move_down"):
		motion.y += ACCELERATION * state.step

	if Input.is_action_pressed("move_left"):
		motion.x -= ACCELERATION * state.step
	elif Input.is_action_pressed("move_right"):
		motion.x += ACCELERATION * state.step

	motion *= FRICTION
	linear_velocity = motion

	tween.start()
	tween.interpolate_property(
			camera,
			"zoom",
			camera.zoom,
			CAMERA_ZOOM_BASE * Vector2.ONE + CAMERA_ZOOM_FACTOR * linear_velocity.length() * Vector2.ONE, 0.12,
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
	)
