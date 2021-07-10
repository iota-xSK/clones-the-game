extends KinematicBody2D
var gravity
var velocity = Vector2.ZERO
var outside_velocity = Vector2.ZERO
export (float) var mass = 1
var player_interact = false
var player
var friction = 0.3

func _ready():
	gravity = get_parent().get("gravity")
	if gravity == null:
		push_error("Parent of the player doesn't have gravity. Please put in a Level2D node. Setting gravity to 1300")
		gravity = 1300
func push():
	for i in get_slide_count():
		var colision = get_slide_collision(i)
		var collider = colision.collider
		if is_instance_valid(collider):
			if collider.is_in_group("physics_bodies") and colision.normal.y == 0:
				collider.velocity.x = (velocity.x * mass) / collider.mass

func _physics_process(delta):
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, friction) # ako je na podu polako usporava
	velocity += outside_velocity # dodaje brzinu koju druge stvari daju, kao npr launchpadi
	velocity.y += gravity * delta # računa brzinu dobivenu gravitacijom
	push() # ako gura druga tijela, promijeni svoju brzinu i njihovu
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.78, false) # radi da se do sad izračunata brzina vidi na ekranu
	outside_velocity = Vector2.ZERO # namješta vanjsku brzinu natrag na nula
