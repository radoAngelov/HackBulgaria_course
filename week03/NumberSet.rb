class NumberSet
	include Enumerable

	def each(&block)
		@numbers.each(&block)
	end

	attr_accessor :numbers , :result

	def initialize
		@numbers = []
		@result = []
	end

	def <<(n)
		if n.is_a?(Numeric)
			@numbers << n if !no_duplicates(n)
		else
			print 'Please enter a Numeric number'
		end
	end

	def no_duplicates(n)
		duplicate_found = false
		@numbers.each { |element| duplicate_found = true if element == n }
		duplicate_found
	end

	def size
		@numbers.length
	end

	def empty?
		has_elements = true
		has_elements = false if @numbers.length == 0 
		has_elements
	end

	def [](filter)
		if filter.is_a?(Filter)
			@numbers.each do |element|
				@result << element if filter.satisfy element
			end
		end
		result
	end
end

module Filterable
	def satisfy(element)

	end

	def &(other)
		Filter.new { |x| self.satisfy(x) && other.satisfy(x) }
	end

	def |(other)
		Filter.new { |x| self.satisfy(x) || other.satisfy(x) }
	end
end

class Filter
	include Filterable
	
	def initialize(&block)
		@block = block
	end

	def satisfy(element)
		@block.call element
	end
end

class TypeFilter
	include Filterable

	def initialize(arg)
		@arg = arg
	end
	
	def satisfy(value)
		case @arg
		when :integer then value.integer?
		when :real then value.real?
		when :complex then value.complex?
		else false
		end
	end
end

class SignFilter
	include Filterable

	def initialize(arg)
		@arg = arg
	end
	
	def satisfy(value)
		case @arg
		when :positive then value > 0
		when :non_positive then value <= 0
		when :negative then value < 0
		when :non_negative then value >= 0
		else false
		end
	end
end
