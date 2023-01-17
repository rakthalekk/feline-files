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
	evidence_selector = get_node("../EvidenceSelector")
	evidence = get_node("../Evidence")
	evidence2 = get_node("../Evidence2")
	ghostcat = get_node("../GhostCat")
	zombietiger = get_node("../ZombieTiger")
	lichleopard = get_node("../LichLeopard")
	witchcat = get_node("../WitchCat")

func _pressed():
	get_parent().get_node("PageFlip").play();
	if(evidence_selector.visible):
		evidence_selector.visible =false;
		evidence.visible =true;
		get_node("../PrevJournal").visible = true
	elif(evidence.visible):
		evidence.visible =false;
		evidence2.visible =true;
	elif(evidence2.visible):
		evidence2.visible =false;
		ghostcat.visible =true;
	elif (intro.visible):
		intro.visible = false
		ghostcat.visible = true
	elif (ghostcat.visible):
		ghostcat.visible = false
		zombietiger.visible = true
	elif (zombietiger.visible):
		zombietiger.visible = false
		lichleopard.visible = true
	elif (lichleopard.visible):
		lichleopard.visible = false
		witchcat.visible = true
		self.visible = false
