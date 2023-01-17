extends Button

var intro
var ghostcat
var zombietiger
var lichleopard
var witchcat
var evidence
var evidence2
var evidence_selector

func _ready():
	intro = get_node("../Intro")
	evidence = get_node("../Evidence")
	evidence_selector = get_node("../EvidenceSelector")
	evidence2 = get_node("../Evidence2")
	ghostcat = get_node("../GhostCat")
	zombietiger = get_node("../ZombieTiger")
	lichleopard = get_node("../LichLeopard")
	witchcat = get_node("../WitchCat")
	
func _pressed():
	get_parent().get_node("PageFlip").play();
	if (witchcat.visible):
		lichleopard.visible = true
		witchcat.visible = false
		get_node("../NextJournal").visible = true
	elif (lichleopard.visible):
		zombietiger.visible = true
		lichleopard.visible = false
	elif (zombietiger.visible):
		ghostcat.visible = true
		zombietiger.visible = false
	elif (ghostcat.visible):
		evidence2.visible = true
		ghostcat.visible = false
	elif(intro.visible):
		intro.visible = false;
		evidence2.visible = true;
	elif(evidence2.visible):
		evidence2.visible = false;
		evidence.visible = true;
	elif(evidence.visible):
		evidence.visible = false;
		evidence_selector.visible = true;
		self.visible = false
