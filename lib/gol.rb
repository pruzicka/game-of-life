# TODO:  generations
# TODO: cycle should exist in the game no from outside
# TODO: stop when all dead, stop when no movement
# TODO: init game and cells in array or random

class Cell
	attr_accessor :future
	attr_accessor :status

	def initialize(status, position_x, position_y)
		@status = status
		@position = [position_x, position_y]
		@future = ""
	end

	def status_print
		if @status == 1
			return "x"
		else
			return " "
		end
	end

	def neighbours
		# 8 cells
		# for [3,2]
		# should return[[2,1],[2,2],[2,3],[3,1],[3,3],[4,1],[4,2],[4,3]]
		x = @position[0]
		y = @position[1]
		neighbours = []
		n1 = [x-1,y-1]
		n2 = [x-1,y]
		n3 = [x-1,y+1]
		n4 = [x,y-1]
		n5 = [x,y+1]
		n6 = [x+1,y-1]
		n7 = [x+1,y]
		n8 = [x+1,y+1]
		neighbours = [n1,n2,n3,n4,n5,n6,n7,n8]
		return neighbours
	end

	def status?
		if @status == 1
			return "alive"
		else 
			return "dead"
		end
	end

	def alive?
		if @status == 1 then true else false end
	end

	def dead?
		if @status == 0 then true else false end
	end

	def position
		return @position
	end

	def position_x?
		return @position[0]
	end

	def position_y?
		return @position[1]
	end

end

class Field

	def initialize(x,y)
		@dimensions = [x,y]
		@grid = create_grid
		@last_grid = []
	end
	
	def last_grid
		return @last_grid
	end

	def current_grid
		@current_grid = []
		cg = @grid.flatten
		i = 0
		while i < cg.length
				@current_grid.push(cg[i].status)
				i += 1
		end
		return @current_grid
	end

	def set_last_grid
		@last_grid = []
		 	lg = @grid.flatten
		 	i = 0
		 	while i < lg.length
				@last_grid.push(lg[i].status)
				i += 1
		 	end
	end


	def  set_future(x,y)
		cell = @grid[x][y]
		status = cell.status
		alive, dead = neighbours_status(x,y)
							
		if status == 1
			if alive < 2
				cell.future = 0
			elsif alive > 3
				cell.future = 0
			elsif alive == 2 || alive == 3
				cell.future = 1
			end
		elsif status == 0 && alive == 3
			cell.future = 1
		elsif status == 0
			cell.future = 0
		end

		# print "after set future\n"
		# print_grid_future
	end

	def evolve
		x = @dimensions[0]
		y = @dimensions[1]
		i = 0
		while i < x
			j = 0
			while j < y
				set_future(i,j)
				j += 1
			end
			i += 1
		end
		set_last_grid
	end 


	def age_cells
		x = @dimensions[0]
		y = @dimensions[1]
		i = 0
		while i < x
			j = 0
			while j < y
				@grid[i][j].status = @grid[i][j].future
				@grid[i][j].future = ""
				j += 1
			end
			i += 1
		end
	end


	def neighbours(x,y)
		p = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
		neighbours = []
		i = 0
		while i < 8
			a = x - p[i][0]
			b = y - p[i][1]
			if a>= 0 && b >= 0
				neighbours.unshift(@grid[a][b].position)
			end
		i += 1
		end
		
		return neighbours

	end

	def neighbours_status(x,y)
		alive = 0
		dead = 0
		p = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
		i = 0
		while i < 8
			# print "x = #{x}, y = #{y}\n"
			a = x + p[i][0]
			b = y + p[i][1]
			# print "a = #{a}, b = #{b}\n"
			if (a >= 0 && b >= 0 && a < @dimensions[0] && b < @dimensions[1] )
				if @grid[a][b].status == 0
				  	dead += 1
				elsif @grid[a][b].status == 1
					alive += 1
				end
			end
			i += 1
		end
		return alive, dead
	end

	def neighbours_sum(x,y)
		sum = 0
		p = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
		i = 0
		while i < 8
			a = x - p[i][0] 
			b = y - p[i][1]
			if a>=0 && b >=0
				sum += @grid[a][b].status
			end
			i += 1
		end
		# n1 = @grid[x-1][y-1].status
		# n2 = @grid[x-1][y].status
		# n3 = @grid[x-1][y+1].status
		# n4 = @grid[x][y-1].status
		# n5 = @grid[x][y+1].status
		# n6 = @grid[x+1][y-1].status
		# n7 = @grid[x+1][y].status
		# n8 = @grid[x+1][y+1].status
		# sum = n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8
		return sum
	end

	def status_of_grid
		dead = 0
		alive = 0
		i = 0
		g = @grid.flatten
		while i < g.length
			if g[i].status == 1
				alive += 1
			elsif g[i].status == 0
				dead += 1
			else
				print "something is wrong...\n"
			end
			i += 1
		end

		return alive, dead
	end

	def print_grid
		i = 0
		print "Alive cells - #{status_of_grid[0]}, Dead cells - #{status_of_grid[1]}\n\n"

		while i < @grid.size
			j = 0
			print "|"
			while  j < @grid[i].size 
				print " #{@grid[i][j].status_print} "
			j += 1
			end
			print "|\n"
			i += 1
		end
	end

	def print_grid_future
		i = 0
		while i < @grid.size
			j = 0
			print "["
			while  j < @grid[i].size 
				print " #{@grid[i][j].future} "
			j += 1
			end
			print "]\n"
			i += 1
		end
	end

	def create_grid
		i = 0
		grid = []
		
		while i < @dimensions[0]
			j = 0
			row = []

			while j < @dimensions[1]
				row.push(create_cell(i,j))
				j += 1
			end
			
			grid[i] = row
			i += 1
		end

		return grid

	end

	def create_cell(x,y)
		status = rand.round
		c = Cell.new(status,x,y)
		return c
	end


	def dimensions?
		return @dimensions
	end

	def grid
		return @grid
	end

	def not_changed
		if current_grid == last_grid
			return true
		else
			return false
		end
	end

	def all_dead?
		if status_of_grid[0] == 0
			return true
		else
			return false
		end
	end

end


class Game

	def initialize
		if ARGV.empty? 
			x = 6
			y = 6
		else
			x = ARGV[0].to_i
			y = ARGV[1].to_i
		end

		@field = Field.new(x,y)
		@generations = 20
	end
	
	def play

		i = 0

		while !@field.all_dead? # || !@field.not_changed do
			print "Generation #{i}\n"

			@field.print_grid

			@field.evolve

			@field.age_cells

			if @field.not_changed
				
				print "not changed\n"
				break
			end

			# sleep 1
			system ("clear")
			i += 1
		end

		if @field.all_dead?
			print "Generation #{i}\n"
			@field.print_grid
			print "All dead after #{i} generations.\n"
		elsif @field.not_changed
			print "No change, no evolution\n"
		end

	end

end

