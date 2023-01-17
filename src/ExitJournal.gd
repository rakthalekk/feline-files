extends Button
var journal
func _ready():
	journal = get_parent()
	
func _pressed():
	journal.visible = false
	get_tree().paused = false;
