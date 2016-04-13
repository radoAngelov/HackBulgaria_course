class Vector2D
  def initialize(x, y)
    @x, @y = x, y
  end

  def x
  	@x
  end

  def x=(value)
  	@x = value
  end

  def y
  	@y
  end

  def y=(value)
  	@y = value
  end

  def length
  	Math.sqrt @x*@x + @y*@y
  end

  def normalize
    array = [@x / length, @y / length]
  end

  def ==(other)
    same = true
    same = false if @x != other.x || @y != other.y
  	
  	same
  end

  def +(other)
  	temp = Vector2D.new @x + other.x, @y + other.y
  end

  def -(other)
    temp = Vector2D.new @x - other.x, @y - other.y
  end

  def *(scalar)
  	temp = Vector2D.new @x * scalar, @y * scalar
  end

  def /(scalar)
    temp = Vector2D.new @x / scalar, @y / scalar
  end

  def to_s
    "(#{@x},#{@y})"
  end
end

class Vector
	def initialize(*components)
	 	@dimension = []
	   	components.each do |component|
	   		@dimension << component
	   	end 
	end

	def dimension
	    @dimension
	end

	def length
	  	result = 0
	    @dimension.each do |component|
	    	result += component * component
		end
		
		result**(1.0/@dimension.length)
	end

	def normalize
	    @dimension.each do |unit|
	    	unit = unit / length
		end
	end

	def [](index)
	    @dimension[index]
	end

	def []=(index, value)
	    @dimension[index] = value
	end

	def ==(other)
	  	same = true
	  	if dimension != other.dimension
	  		same= false
	  	end 
	end

	def +(vector_of_same_dimension_or_scalar)
	  	new_dimension = []

	  	if @dimension.length == vector_of_same_dimension_or_scalar.dimension.length
		    @dimension.each_with_index do |unit, index|
	    		new_dimension << unit + vector_of_same_dimension_or_scalar[index]
	    	end
	    end

	    temp = Vector.new new_dimension
	end

	def -(vector_of_same_dimension_or_scalar)
	  	new_dimension = []

	  	if @dimension.length == vector_of_same_dimension_or_scalar.dimension.length
		    @dimension.each_with_index do |unit, index|
	    		new_dimension << unit - vector_of_same_dimension_or_scalar[index]
	    	end
	    end

	    temp = Vector.new new_dimension
	end

	def *(scalar)
	  	new_dimension = []

	  	 @dimension.each { |unit| new_dimension << unit * scalar }

	    temp = Vector.new new_dimension
	end

  	def /(scalar)
    	new_dimension = []

	  	 @dimension.each  { |unit| new_dimension << unit / scalar }
	    
	    temp = Vector.new new_dimension
  	end

	def to_s
   		@dimension.to_s
  	end
end