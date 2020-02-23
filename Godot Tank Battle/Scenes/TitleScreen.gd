extends Control

export(float) var blink_interval = 0.1

onready var title1 = $Title1
onready var title2 = $Title2

var counter: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	if counter > blink_interval:
		blink()
		counter = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start()

func blink():
	if title1.visible:
		title1.visible = false
		title2.visible = true
	else:
		title1.visible = true
		title2.visible = false

func start():
	print("let's a-go!")
