extends ProgressBar

@export var player: PLAYER

func _ready():
	if player:
		player.sanidadeChanged.connect(update)
		update()
	else:
		print("Player is not assigned in the inspector")


func update():
	value = player.currentSanidade * 100 / player.maxSanidade
	
	
	
	
