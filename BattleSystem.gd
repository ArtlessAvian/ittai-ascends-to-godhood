extends Control

var active_partymember: PartyMember
var ready_partymembers: Array[PartyMember] = []

var queued_battle_participant: Array[BattleParticipant] = []
var animating_battle_participant: BattleParticipant


func _process(_delta: float):
	for child in %Party.get_children():
		if not child.get_node("BattleTimer").is_stopped():
			continue
		if child in ready_partymembers:
			continue
		if child in queued_battle_participant:
			continue
		if child == animating_battle_participant:
			continue
		if child == active_partymember:
			continue
		ready_partymembers.append(child)

	if len(ready_partymembers) > 0 and active_partymember == null:
		active_partymember = ready_partymembers.pop_front()
		$Panel2.show()

	if animating_battle_participant != null and animating_battle_participant.done_animating():
		animating_battle_participant.get_node("BattleTimer").start()
		animating_battle_participant = null

	if animating_battle_participant == null and len(queued_battle_participant) > 0:
		animating_battle_participant = queued_battle_participant.pop_front()
		animating_battle_participant.queued_action.call()

	for child in %Party.get_children():
		child.modulate = Color.WHITE
		if child == active_partymember:
			child.modulate = Color.RED
		elif child in queued_battle_participant:
			child.modulate = Color.BLUE
		elif child in ready_partymembers:
			child.modulate = Color.GREEN


func _on_attack_pressed() -> void:
	$Selector.show()
	$Panel2.hide()
	($Selector as Selector).callback = self.queue_attack


func queue_attack(target: BattleParticipant) -> void:
	active_partymember.queued_action = active_partymember.do_attack.bind(target)
	queued_battle_participant.append(active_partymember)
	active_partymember = null


func _on_unique_pressed() -> void:
	pass  # Replace with function body.


func _on_magic_pressed() -> void:
	pass  # Replace with function body.


func _on_item_pressed() -> void:
	pass  # Replace with function body.
