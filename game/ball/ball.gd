# Copyright © 2018 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends RigidBody2D
class_name Ball

var motion = Vector2()

# The starting ball speed
const BASE_SPEED = 275

# Speed factor on every bounce
var speed_factor = 1.01

func _draw() -> void:
	draw_circle(Vector2(), 10.0, Color(0.9, 0.9, 0.9, 1))

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	pass