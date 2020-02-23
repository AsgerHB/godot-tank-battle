extends Node2D

export(int) var worm_walk = 100

var worm_x = 1
var worm_y = 1

const WIDTH = 50
const HEIGHT = 40

func is_oob(x, y):
	return not(x > 0 and x < WIDTH and y > 0 and y < HEIGHT)

func adjacent_cells(x, y, a):
	return [[x + a, y], [x - a, y], [x, y - a], [x, y - a]]

func check_empty(x, y):
	return $TileMap.get_cell(x, y) == 3

func set_empty(x, y):
	$TileMap.set_cell(x, y, 3)

func reset():
	for x in range(0, WIDTH):
		for y in range(0, HEIGHT):
			$TileMap.set_cell(x, y, 1)
			
func range_list(a, b, jump):
	var res = []
	for i in range(a, b, jump):
		res.push_front(i)
	return res

func create_walk(x, y):
	for i in range_list(0, 3, 1)[randi() % 4]:
		var direction = adjacent_cells(x, y, 2)[i]
		
		var tx = direction[0]
		var ty = direction[1]
		
		if not is_oob(tx, ty) and not check_empty(tx, ty):
			set_empty(tx, ty)
			return [x, y]

	return [null, null]

func hunt(hunt_list):
	for i in range(100):
		for x in hunt_list:
			var finished = true
			
			for y in range(1, HEIGHT - 1, 2):
				if check_empty(x, y):
					finished = false
					
					for direction in adjacent_cells(x, y, 2):
						var tx = direction[0]
						var ty = direction[1]
						
						if not is_oob(tx, ty) and check_empty(tx, ty):
							return [x, y]
			
			if finished:
				hunt_list.remove(x)
				break

	return [null, null]
	
func hunt_and_kill():
	var hunt_list = range_list(0, WIDTH + 1, 1)
	
	var x = 2 * randi() % (WIDTH / 2 - 1) + 1
	var y = 2 * randi() % (HEIGHT / 2 - 1) + 1
	
	for i in range(100):
		while x and y:
			var walk = create_walk(x, y)

			x = walk[0]
			y = walk[1]

		var hunt = hunt(hunt_list)

		x = hunt[0]
		y = hunt[1]

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		worm_x = 1
		worm_y = 1

		reset()
		randomize()

		hunt_and_kill()
		
		
