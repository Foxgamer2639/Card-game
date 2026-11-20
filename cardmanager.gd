extends Node2D

var card_being_draged 
var screen_size

const COLLITION_MASK_CARD = 1

func _ready() -> void:
	screen_size = get_viewport_rect()
	
	

func _process(delta: float) -> void:
	if card_being_draged:
		
		var mouse_pos = get_global_mouse_position()
		card_being_draged.position = Vector2(clamp(mouse_pos.x,0,screen_size.size.x),
			 clamp(mouse_pos.y,0,screen_size.size.y))
		

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				card_being_draged = card 
		else:
			card_being_draged = null
			
			
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	print("hovered")

func on_hovered_off_card(card):
	print("hovered off")

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLITION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return (result[0].collider.get_parent())
		return null
	

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
