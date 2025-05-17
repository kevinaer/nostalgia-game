extends Node
class_name PlayerAnimationStateMachine

@onready var _animation_tree: AnimationTree = %AnimationTree
#@onready var _animation_state: AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/playback")

func move(blend_vector: Vector2):
	_animation_tree.set("parameters/IdleWalk/blend_position", blend_vector.length())
