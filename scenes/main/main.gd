extends Node2D

enum GRID_STATE {
	EMPTY,
	SAND,
	WATER,
}

@onready var tiles: TileMap = %tiles
@onready var particles: Label = %particles

const tile_size := Vector2i(4,4)
var grid = []

var frame_counter : int = 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = createGrid(400,200)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	frame_counter += 1
	calculate_next_iteration()
	#if frame_counter / 2 == 0:
	#	calculate_next_iteration()
	#	frame_counter = 0
	
	#if Input.is_action_pressed("left_click"):
	#	insert_tiles_into_world(5)
	
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click"):
		insert_tiles_into_world(5)
		#var mouse_position = get_global_mouse_position()
		#var grid_position = Vector2i(mouse_position) / tile_size
		#
		#if grid[grid_position.y][grid_position.x] == GRID_STATE.EMPTY:
		#	grid[grid_position.y][grid_position.x] = GRID_STATE.SAND
		#	tiles.set_cell(0, grid_position, 0, Vector2i(0,0))
		#	print(grid_position)
	pass

func createGrid(cols, rows) -> Array:
	var output = []
	
	for x in range(rows):
		output.append([])
		for y in range(cols):
			output[x].append(0)
	
	return output

func calculate_next_iteration() -> void:
	#var next_frame_grid = createGrid(grid.size(), grid[0].size())
	for row in range(grid.size()-1,-1,-1):
		#print(row)
		for col in range(grid[0].size()):
			if grid[row][col] == GRID_STATE.SAND and row + 1 <= grid.size() - 1:
				#print("tile is sand: ", Vector2(col,row))
				if grid[row+1][col] == GRID_STATE.EMPTY:
					#print("sand falling")
					grid[row][col] = GRID_STATE.EMPTY
					tiles.erase_cell(0, Vector2(col,row))
					grid[row+1][col] = GRID_STATE.SAND
					tiles.set_cell(0, Vector2(col,row+1), 0, Vector2(0,0))
				#elif (col-1 >= 0 and grid[row+1][col-1] == GRID_STATE.EMPTY) and (col+1 <= grid[0].size()-1 and grid[row+1][col+1] == GRID_STATE.EMPTY):
				#	var rng = RandomNumberGenerator.new()
				#	rng.randomize()
				#	var direction = rng.randi_range(0,1)
				#	if direction == 0: #left
				#		grid[row][col] = GRID_STATE.EMPTY
				#		tiles.erase_cell(0, Vector2(col,row))
				#		grid[row+1][col-1] = GRID_STATE.SAND
				#		tiles.set_cell(0, Vector2(col-1,row+1), 0, Vector2(0,0))
				#	else: #right
				#		grid[row][col] = GRID_STATE.EMPTY
				#		tiles.erase_cell(0, Vector2(col,row))
				#		grid[row+1][col+1] = GRID_STATE.SAND
				#		tiles.set_cell(0, Vector2(col+1,row+1), 0, Vector2(0,0))
				elif col-1 >= 0 and grid[row+1][col-1] == GRID_STATE.EMPTY:
					grid[row][col] = GRID_STATE.EMPTY
					tiles.erase_cell(0, Vector2(col,row))
					grid[row+1][col-1] = GRID_STATE.SAND
					tiles.set_cell(0, Vector2(col-1,row+1), 0, Vector2(0,0))
				elif col+1 <= grid[0].size()-1 and grid[row+1][col+1] == GRID_STATE.EMPTY:
					grid[row][col] = GRID_STATE.EMPTY
					tiles.erase_cell(0, Vector2(col,row))
					grid[row+1][col+1] = GRID_STATE.SAND
					tiles.set_cell(0, Vector2(col+1,row+1), 0, Vector2(0,0))
	#grid = next_frame_grid
func insert_tiles_into_world(square_size : int) -> void:
	var mouse_position = get_global_mouse_position()
	var grid_position = Vector2i(mouse_position) / tile_size
	
	for y in range(square_size):
		for x in range(square_size):
			particles.counter += 1
			grid[grid_position.y + y][grid_position.x + x] = GRID_STATE.SAND
