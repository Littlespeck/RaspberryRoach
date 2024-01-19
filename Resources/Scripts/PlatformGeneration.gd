extends Node2D

#Add the platformscene here vvvv
var BaconPlatformScene
var platform = 0

func _ready():
	randomize()
	$Player/PlayerScriptNode.PlatformErased.connect(SpawnPlatform)

func _physics_process(delta):
	SpawnPlatform()

func SpawnPlatform():

	var RandNum = randf_range(0,3)
	$PlatformContainer.add_child(BaconPlatformScene)
	if RandNum >= 2:
		BaconPlatformScene.position = $SpawnLocations/SpawnLocation3.position 
	if RandNum >= 1:
		BaconPlatformScene.position = $SpawnLocations/SpawnLocation2.position 
	if RandNum >= 0:
		BaconPlatformScene.position = $SpawnLocations/SpawnLocation1.position


