extends BattleParticipant
class_name PartyMember

var target: BattleParticipant = null


func _ready():
	$BattleTimer.start()
