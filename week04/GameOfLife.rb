class Board

	Point = Struct.new(:x, :y)

	attr_accessor :board

	def initialize(*points)
		@board = Array.new(5){Array.new(5)}
		points.each { |x,y| @board[x][y] = true }
	end

	def count(x,y)
		
		hash = {
			0 => nil,
			1 => nil,
			2 => true,
			3 => true,
			4 => nil,
			5 => nil,
			6 => nil,
			7 => nil,
			8 => nil
		}

		count_alive = 0
		i = x - 1
		while i < x + 2
			j = y - 1
			while j < y + 2
				count_alive += 1 if @board[i][j] && i > - 1 && i < board.length && j > -1 && j < board[i].length
				j += 1
			end
			i += 1
		end
		count_alive - 1 if @board[x][y]
		if @board[x][y] = false && hash[count_alive]!= 3
			false
		else 
			hash[count_alive]
		end
			
	end

	def next_generation
		new_board = Array.new(5){Array.new(5)}
		i = 0
		while i < @board.length
			j = 0
			while j < @board[i].length
				new_board[i][j] = count(i,j)
				j += 1
			end
			i += 1
		end
		p new_board
	end

	def show
		index = 0
		while index < @board.length
			p board[index]
			index += 1
		end
	end
end

a = Board.new [1,2],[1,4]
a.next_generation