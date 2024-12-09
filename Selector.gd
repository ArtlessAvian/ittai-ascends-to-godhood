extends Node2D
class_name Selector

var index = 0
var callback: Callable = self.noop


func noop(who: BattleParticipant):
	pass


func _ready():
	index = 0
	reaim_pointer()


func _input(event: InputEvent) -> void:
	if not self.visible:
		return

	if event.is_action_pressed("ui_up"):
		index -= 1
		reaim_pointer()
	if event.is_action_pressed("ui_down"):
		index += 1
		reaim_pointer()
	if event.is_action_pressed("ui_select"):
		var layout = %EnemyLayout as Node
		self.callback.call(get_selected_participant())
		self.callback = self.noop
		self.hide()
	#if event is InputEventMouse:
	#print(event.global_position)


func get_selected_participant() -> BattleParticipant:
	var layout = %EnemyLayout as Node
	return layout.get_child(index % layout.get_child_count()) as BattleParticipant


func reaim_pointer():
	$Sprite2D.global_position = get_selected_participant().global_position + Vector2.RIGHT * 30
