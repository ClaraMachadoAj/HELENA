extends Area2D

@export var interactor: Node2D
@export var interaction_action : StringName = "INTERACT"

var selected_interactable : Interactable
var nearby_interatables: Array[Interactable]

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent):
	if(event.is_action_pressed(interaction_action)):
		if(selected_interactable != null):
			selected_interactable.interact(interactor)

func _on_area_entered(area: Area2D):
	if(area is Interactable):
		nearby_interatables.push_back(area)
		
		if(selected_interactable == null):
			selected_interactable = nearby_interatables[0]

func _on_area_exited(area: Area2D):
	if(area is Interactable):
		nearby_interatables.erase(area)
		
		selected_interactable.stop_interaction(interactor)
		
		if(nearby_interatables.size() > 0):
			selected_interactable = nearby_interatables[0]
