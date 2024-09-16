extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		resume()

func _process(delta):
	testEsc()
