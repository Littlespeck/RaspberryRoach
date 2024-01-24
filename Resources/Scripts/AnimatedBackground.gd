extends ColorRect

const STRAWBERRY = preload("res://Resources/Scenes/Objects/Fruit/strawberry.tscn")
const MUSHROOM = preload("res://Resources/Scenes/Objects/Fruit/mushroom.tscn")
const MANDARIN = preload("res://Resources/Scenes/Objects/Fruit/mandarin.tscn")
const GUMMY = preload("res://Resources/Scenes/Objects/Fruit/gummy.tscn")
const CHOCOLATE = preload("res://Resources/Scenes/Objects/Fruit/chocolate.tscn")
const CARROT = preload("res://Resources/Scenes/Objects/Fruit/carrot.tscn")
const CANDY = preload("res://Resources/Scenes/Objects/Fruit/candy.tscn")
const BROKKOLI = preload("res://Resources/Scenes/Objects/Fruit/brokkoli.tscn")
const BERRY = preload("res://Resources/Scenes/Objects/Fruit/berry.tscn")

@onready var FoodSpawnTimer = $FoodSpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ChooseFruit():
	var randNum = randi_range(1,9)
	var randNumPOS = randi_range(25, 350) + randi_range(25, 350)
	var Instance
	var LastInstance

	match randNum:
		1:
			Instance = STRAWBERRY.instantiate()
		2:
			Instance = MUSHROOM.instantiate()
		3:
			Instance = MANDARIN.instantiate()
		4:
			Instance = GUMMY.instantiate()
		5:
			Instance = CHOCOLATE.instantiate()
		6:
			Instance = CARROT.instantiate()
		7:
			Instance = CANDY.instantiate()
		8:
			Instance = BROKKOLI.instantiate()
		9:
			Instance = BERRY.instantiate()
	add_child(Instance)
	Instance.position = Vector2i(randNumPOS,-25)
	LastInstance = Instance


func _on_food_spawn_timer_timeout():
	ChooseFruit()
