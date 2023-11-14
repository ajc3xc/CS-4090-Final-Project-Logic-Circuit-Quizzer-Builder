extends Node

#check if node or drop down menu is being dragged
var is_dragging = false
var node_selected = false

#stores graph of connected lines as dictionary
#necessary because multiple lines must be able to be plotted
var line_nodes = {}

#node 
var selected_node = null
