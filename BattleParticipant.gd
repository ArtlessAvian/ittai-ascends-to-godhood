extends Node2D
class_name BattleParticipant

@export var health: int = 10

var queued_action: Callable = self.noop


func noop():
	pass


func done_animating() -> bool:
	var animation = get_node_or_null("AnimationPlayer")
	if animation is AnimationPlayer and animation.is_playing():
		return false
	return true


func do_attack(target: BattleParticipant) -> void:
	target.health -= 1
	prints(self, "attacks", target)
	$AnimationPlayer.play("Attack")
