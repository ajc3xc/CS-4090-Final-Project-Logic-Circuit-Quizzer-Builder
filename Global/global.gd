extends Node

#check if node or drop down menu is being dragged
var is_dragging = false

#stores graph of connected lines as dictionary
#necessary because multiple lines must be able to be plotted
var line_nodes = {}
