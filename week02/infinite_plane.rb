class InfinitePlane
	def initialize(x, y)
		@x = x
		@y = y
	end

	def move_to_directions(directions)
		inverse = false

		directions.chars.each do |char|
			if !inverse
				if char == '<'
					@x += 1 
				elsif char == '>'
					@x -= 1 
				elsif char == 'v'
					@y += 1
				elsif char == '^'
					@y -= 1
				else
				inverse = !inverse 
				end
			else
				if char == '<'
					@x -= 1 
				elsif char == '>'
					@x += 1 
				elsif char == 'v'
					@y -= 1 
				elsif char == '^'
					@y += 1 
				else
					inverse = !inverse 
				end
			end
		end
	end

	def to_array
		position=[@x, @y]	
	end
end