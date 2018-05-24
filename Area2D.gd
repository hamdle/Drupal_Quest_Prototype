extends Area2D

var show = false

func _ready():
	$MenuBlock.hide()
	$MenuBlock/MB1.disabled = true;
	$MenuBlock/MB2.disabled = true;
	
func _input_event(viewport, event, shape_idx):
	if event.is_pressed():
		show = !show
		if show == true:
			$MenuBlock.show()
			$MenuBlock/MB1.disabled = false;
			$MenuBlock/MB2.disabled = false;
		else:
			$MenuBlock.hide()
			$MenuBlock/MB1.disabled = true;
			$MenuBlock/MB2.disabled = true;