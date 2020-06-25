extends KinematicBody2D

export var velocidade = 200
var chave = false
var chave2 = false
var perto_chave = false
var porta = false
var porta2 = false

onready var node_chave = get_parent().get_node("chave")
onready var node_chave2 = get_parent().get_node("chave2")
onready var node_porta = $"../porta"
onready var node_porta2 = $"../porta2"

func _ready():
	pass

func _process(delta):
	var dir = Vector2()
	if Input.is_action_pressed("up"):
		dir.y = - 1
	if Input.is_action_pressed("down"):
		dir.y =  1
	if Input.is_action_pressed("left"):
		dir.x = - 1
	if Input.is_action_pressed("right"):
		dir.x =  1
	move_and_slide(dir * velocidade)

func _input(event):
	chaves()
	portas()
	controle_chave()
	controle_porta()

func chaves():
	if chave and perto_chave and Input.is_key_pressed(KEY_SPACE):
		node_chave.queue_free()
		perto_chave = false
	if chave2 and perto_chave and Input.is_key_pressed(KEY_SPACE):
		node_chave2.queue_free()
		perto_chave = false

func portas():
	if porta and chave and Input.is_key_pressed(KEY_SPACE):
		node_porta.queue_free()
		chave = false
		node_chave2.visible = true
	if porta2 and chave2 and Input.is_key_pressed(KEY_SPACE):
		node_porta2.queue_free()
		chave2 = false

func controle_chave():
	if chave and perto_chave and Input.is_action_pressed("x"):
		node_chave.queue_free()
		perto_chave = false
	if chave2 and perto_chave and Input.is_action_pressed("x"):
		node_chave2.queue_free()
		perto_chave = false

func controle_porta():
	if porta and chave and Input.is_action_pressed("x"):
		node_porta.queue_free()
		chave = false
		node_chave2.visible = true
	if porta2 and chave2 and Input.is_action_pressed("x"):
		node_porta2.queue_free()
		chave2 = false

func _on_area_body_entered(body):
	if body.name == "chave":
		chave = true
		perto_chave = true
	if body.name == "chave2":
		chave2 = true
		perto_chave = true
	if body.name == "porta":
		porta = true
	if body.name == "porta2":
		porta2 = true

func _on_area_body_exited(body):
	if body.name == "porta2":
		porta2 = false
	if body.name == "porta":
		porta = false
