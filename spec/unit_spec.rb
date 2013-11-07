require 'lib/gol'


describe "grid" do
	before(:each) do
		@g = Field.new(6,6)
	end

	it "should set up future based on neighbours(3,2), 1 alive neighbours" do
		@g.grid[2][1].status = 0
		@g.grid[2][2].status = 0
		@g.grid[2][3].status = 0
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0
		# alive
		@g.grid[3][2].status = 1

		@g.set_future(3,2)
		@g.grid[3][2].future.should eq(0)
	end

	it "should set up future based on neighbours(3,2), 2 alive neighbours" do
		@g.grid[2][1].status = 0
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 0
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0
		#alive
		@g.grid[3][2].status = 1

		@g.set_future(3,2)
		@g.grid[3][2].future.should eq(1)
	end

	it "should set up future based on neighbours(3,2), 3 alive neighbours" do
		@g.grid[2][1].status = 1
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 1
		@g.grid[3][1].status = 0
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0

		#alive
		@g.grid[3][2].status = 1

		@g.set_future(3,2)
		@g.grid[3][2].future.should eq(1)
	end

	it "should set up future based on neighbours(3,2), 4 alive neighbours" do
		@g.grid[2][1].status = 1
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 1
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0

		#alive
		@g.grid[3][2].status = 1

		@g.set_future(3,2)
		@g.grid[3][2].future.should eq(0)
	end

	it "should set up future based on neighbours(3,2), 3 alive neighbours" do
		@g.grid[2][1].status = 1
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 0
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0

		#alive
		@g.grid[3][2].status = 0

		@g.set_future(3,2)
		@g.grid[3][2].future.should eq(1)
	end

	it "should evolve all cells, change status to future, reset future" do
		@g.grid[0][0].status = 0
		@g.grid[0][0].future = 1

		@g.age_cells

		cell_status = @g.grid[0][0].status
		cell_future = @g.grid[0][0].future

		cell_status.should  == 1
		cell_future.should == ""
	end


	it "should return dimension" do
		@g.dimensions?.should eq([6,6])
	end

	it "should return size of init" do
		@g.grid.size.should == 6
	end

	it "should return array in array" do
		@g.grid[0].size.should == 6
	end

	it "should have dead or alive in each grid cell after init" do
		pending
	end

	it "should have Cell.class inside" do
		@g.grid[0][0].class.should eq(Cell)
	end

	it "should return surroudning cell to @g.neighbours(3,2)" do
		@g.neighbours(3,2).should eq([[2,1],[2,2],[2,3],[3,1],[3,3],[4,1],[4,2],[4,3]])
	end

	it "should report number of dead surrounding cells (3,2)" do
		@g.grid[2][1].status = 0
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 0
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0
		@g.neighbours_status(3,2).should eq([2,6])
	end

	it "should report number of dead surrounding cells (0,0)" do
		@g.grid[0][1].status = 0
		@g.grid[1][0].status = 1
		@g.grid[1][1].status = 1

		@g.grid[3][1].status = 1
		@g.grid[0][5].status = 1
		@g.grid[5][4].status = 1
		@g.grid[4][5].status = 1
		@g.grid[5][5].status = 1
		@g.neighbours_status(0,0).should eq([2,1])
	end


	it "should return sum of surrounding cells for @g.neighbours_sum(3,2)" do
		@g.grid[2][1].status = 0
		@g.grid[2][2].status = 1
		@g.grid[2][3].status = 0
		@g.grid[3][1].status = 1
		@g.grid[3][3].status = 0
		@g.grid[4][1].status = 0
		@g.grid[4][2].status = 0
		@g.grid[4][3].status = 0
		@g.neighbours_sum(3,2).should eq(2)
	end

	it "should return sum of surrounding cells for @g.neighbours_sum(0,0)" do
		@g.grid[0][1].status = 0
		@g.grid[1][0].status = 1
		@g.grid[1][1].status = 1

		@g.grid[3][1].status = 1
		@g.grid[0][5].status = 1
		@g.grid[5][4].status = 1
		@g.grid[4][5].status = 1
		@g.grid[5][5].status = 1
		@g.neighbours_sum(0,0).should eq(2)
	end
end


# [0 0 0 0 0 0]
# [0 0 0 0 0 0]
# [0 0 0 0 0 0]
# [0 0 1 0 0 0]
# [0 0 0 0 0 0]
# [0 0 0 0 0 0]


describe "cell" do
	before(:each) do
		@dead = Cell.new(0, 3, 2)
		@alive = Cell.new(1 ,3, 2)
		@cell = @alive
	end

	it "alive should respond to status with 1" do
		@cell.status.should eq(1)
	end

	it "dead should respond to status with 0" do
		@dead.status.should eq(0)
	end


	it "should be able to tell surrounding 8 positions" do
		@cell.neighbours.should  eq([[2,1],[2,2],[2,3],[3,1],[3,3],[4,1],[4,2],[4,3]])
	end


	it "should have future value" do
		@cell.future.should eq("")
	end

	it "should have position in grid" do
		@cell.position.should eq([3,2])
	end

	it "cell should have position_x as first number" do
		@cell.position_x?.should eq(3)
	end

	it "cell should have position_y as second number" do
		@cell.position_y?.should eq(2)
	end

	it "cell should respond with dead if dead" do
		@dead.status?.should == 'dead'
	end

	it "Alive cell should respond with true to alive?" do
		@alive.alive?.should eq(true)
	end

	it "Alive cell should respond with false to dead?" do
		@alive.dead?.should_not eq(true)
	end

end
