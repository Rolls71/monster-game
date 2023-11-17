extends Control

var Boo
var Clint
var Soup
var Mage
var Barbarian
var Ranger

var friends
var enemies
var characters

func _ready():
	Boo = get_node("Boo")
	Clint = get_node("Clint")
	Soup = get_node("Soup")
	Mage = get_node("Mage")
	Barbarian = get_node("Barbarian")
	Ranger = get_node("Ranger")
	
	friends = [Boo, Clint, Soup]
	enemies = [Mage, Barbarian, Ranger]
	characters = [Boo, Clint, Soup, Mage, Barbarian, Ranger]
