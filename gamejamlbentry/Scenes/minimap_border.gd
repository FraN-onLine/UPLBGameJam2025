extends Line2D

func make_circle(radius: float, segments: int):
	var points: PackedVector2Array = PackedVector2Array()
	for i in range(segments):
		var angle: float = float(i) * TAU / segments
		var x: float = cos(angle) * radius
		var y: float = sin(angle) * radius
		points.append(Vector2(x, y))
	points.append(points[0])  # Close the circle by adding the first point again
	self.points = points

# Example usage in your script
func _ready():
	make_circle(100, 64) # Create a circle with radius 50 and 64 segments
