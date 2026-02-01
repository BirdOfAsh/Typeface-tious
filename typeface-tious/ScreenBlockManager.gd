extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	firstObject = $GodotFace1
	secondObject = $GodotFace2
	thirdObject = $GodotFace3
	forthObject = $GodotFace4
	lastSpawnValue = 0
	lastDespawnValue = 0


var lastSpawnValue : int
var lastDespawnValue : int

var elapsedTime : float
var elapsedTimeInSecs : int

var firstObject : Node2D
var secondObject : Node2D
var thirdObject : Node2D
var forthObject : Node2D 
var objectsOnScreen : Array[int] = []

var spawnRate : int = 10 #spawns something every given seconds
var despawnRate : int = 5 #despawns oldest item every given seconds

func _process(delta: float) -> void:
	elapsedTime += delta 
	elapsedTimeInSecs = int(elapsedTime) #this might be weird with rounding, and not completely accurate, but it works so here we are
	
	if elapsedTimeInSecs % despawnRate == 0 and elapsedTimeInSecs != lastDespawnValue:
		print(elapsedTimeInSecs, " secs")
		lastDespawnValue = elapsedTimeInSecs
		if objectsOnScreen.size() > 0:
			objectsOnScreen.erase(objectsOnScreen[0])
	
	if elapsedTimeInSecs % spawnRate == 0 and elapsedTimeInSecs != lastSpawnValue:
		print(elapsedTimeInSecs, " secs")
		lastSpawnValue = elapsedTimeInSecs
		var randomChoice : int = (randi() % 4) + 1
		objectsOnScreen.append(randomChoice)
		
	checkArray()

#there is no way this is optimal programming but I can't think of anything better at the moment
func checkArray() -> void:
	firstObject.onScreen = true if objectsOnScreen.has(1) == true else false
	secondObject.onScreen = true if objectsOnScreen.has(2) == true else false
	thirdObject.onScreen = true if objectsOnScreen.has(3) == true else false
	forthObject.onScreen = true if objectsOnScreen.has(4) == true else false
	if objectsOnScreen.has(0) == true:
		print("Something isn't indexed correctly")
