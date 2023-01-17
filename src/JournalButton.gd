extends Button

var journal

func _ready():
	journal = get_parent().get_node("Journal")
	
func _pressed():
	journal.visible = true
