# Copyright © 2018 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends RigidBody2D
class_name Ball

# The starting ball speed
const BASE_SPEED = 275

# The maximum ball speed
const MAX_SPEED = 600

# Speed factor on every bounce
var speed_factor := 1.01

# Whether the ball has been touched by a paddle or not
var claimed := false

onready var claim_animation_player := $ClaimAnimationPlayer as AnimationPlayer

var motion := Vector2()

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	linear_velocity = linear_velocity.clamped(MAX_SPEED)

	for body in get_colliding_bodies():
		if body is Paddle:
			claim()

		if body is Brick:
			body.destroy()

		if not claimed:
			# Destroy unclaimed balls on their first collision
			queue_free()

# Called when the ball is claimed (i.e. touched by a paddle)
func claim():
	if not claimed:
		claim_animation_player.play("claim")

	claimed = true
